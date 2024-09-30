import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductShoe extends ChangeNotifier {
  List<ProductModel> products = [];
  List<Uint8List>? pickedImages; 
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> createProduct({
    String? id, 
    required String productName,
    required String productDescription,
    required List<String> sizes,
    required double price,
    required int stock,
    required String category, 
    required bool isNewArrival, 
    required bool isTopCollection, 
  }) async {
    try {
      if (pickedImages != null && pickedImages!.isNotEmpty) {
        List<String> imageUrls = []; 

        for (var image in pickedImages!) {
          String imageUrl = await uploadImage(image); 
          if (imageUrl.isNotEmpty) {
            imageUrls.add(imageUrl); 
          }
        }

        final product = ProductModel(
           id: id ?? generateRandomId(),
          productName: productName,
          productDescription: productDescription,
          sizes: sizes,
          price: price,
          stock: stock,
          uploadImages: imageUrls, 
          category: category,
          isNewArrival: isNewArrival,
          isTopCollection: isTopCollection,
        );
          
        await FirebaseFirestore.instance
            .collection("products")
            .add(product.toJson());
        products.add(product);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<void> fetchProducts() async {
  try {
    print("inside product");
    final querySnapshot = await FirebaseFirestore.instance.collection("products").get();
    products = querySnapshot.docs.map((doc) => 
    ProductModel.fromJson(doc.data())).toList();
    print("product:${products}");
    notifyListeners();
  } catch (e) {
    print("Error fetching products: $e");
  }
}

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true, 
    );
    if (result != null) {
      pickedImages = result.files.map((file) => file.bytes!).toList().cast<Uint8List>();
      notifyListeners();
    }
  }

  Future<String> uploadImage(Uint8List imageData) async {
    try {
      final storageRef = storage.ref().child('productImages/${DateTime.now().millisecondsSinceEpoch}.png');
      UploadTask uploadTask = storageRef.putData(imageData);
      TaskSnapshot snapshot = await uploadTask;
      String link = await snapshot.ref.getDownloadURL();
      return link;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  bool _isNewArrival = false;
  bool _isTopCollection = false;

  bool get isNewArrival => _isNewArrival;
  bool get isTopCollection => _isTopCollection;

  void toggleNewArrival() {
    _isNewArrival = !_isNewArrival;
    notifyListeners();
  }

  void toggleTopCollection() {
    _isTopCollection = !_isTopCollection;
    notifyListeners();
  }
   void resetCheckboxes() {
    _isNewArrival = false;
    _isTopCollection = false;
    notifyListeners();
  }

  void clearPickedImages() {
    pickedImages = null;
    notifyListeners();
  }

 static String generateRandomId() {
    final Random random = Random();
    return 'product_${random.nextInt(10000)}'; 
  }
}
