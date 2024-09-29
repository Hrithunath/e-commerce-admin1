
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/view_models/catergoryshoe.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CategoryShoe extends ChangeNotifier {
  List<CategoryModel> categories = [];
  Uint8List? pickedImage;
  String? selectedCategory;

  CategoryShoe(){
    fetchCategories();
  }

  final FirebaseStorage storage = FirebaseStorage.instance;

 Future<void> createCategory(String categoryName) async {
  try {
    if (pickedImage != null) {
      String imageUrl = await uploadImage();

      if (imageUrl.isNotEmpty) {
        final category = CategoryModel(
          categoryName: categoryName,
          imageUrl: imageUrl,
          id: generateRandomId(), 
        );

        await FirebaseFirestore.instance.collection("categories").add(category.toJson());
        categories.add(category);
        notifyListeners();
      }

      
    }
  } catch (e) {
    print("Error adding Category: $e");
  }
}
  
  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
      categories = snapshot.docs.map((doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      Uint8List? pickedImage = result.files.first.bytes;

      if (pickedImage != null) {
        this.pickedImage = pickedImage;
        notifyListeners();
      }
    }
  }

  Future<String> uploadImage() async {
    try {

      final storageRef = storage.ref().child('categoryImages/${DateTime.now().millisecondsSinceEpoch}.png');
      UploadTask uploadTask = storageRef.putData(pickedImage!);
      TaskSnapshot snapshot = await uploadTask;
      String link = await snapshot.ref.getDownloadURL();
      return link;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  Future<void> editCategory(CategoryModel updatedCategory) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(updatedCategory.id)
          .update(updatedCategory.toJson());

      int index = categories.indexWhere((category) => category.id == updatedCategory.id);
      if (index != -1) {
        categories[index] = updatedCategory;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating Category: $e");
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await FirebaseFirestore.instance.collection('categories').doc(categoryId).delete();
      categories.removeWhere((category) => category.id == categoryId);
      notifyListeners();
    } catch (e) {
      print("Error deleting Category: $e");
    }
  }

  void setCategory(String Category){
    selectedCategory = Category;
    notifyListeners();
  }

  void clearPickedImage() {
    pickedImage = null;
    notifyListeners();
  }

   String generateRandomId() {
  final Random random = Random();
  return 'category_${random.nextInt(10000)}'; 
}
}
 

