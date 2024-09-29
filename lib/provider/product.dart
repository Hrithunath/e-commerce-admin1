import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/view_models/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductShoe extends ChangeNotifier {
  List<ProductModel> products = [];
  List<Uint8List>? pickedImages; 

  final FirebaseStorage storage = FirebaseStorage.instance;

 

  Future<void> createProduct({
    required String productName,
    required String productDescription,
    required List<String> sizes,
    required double price,
    required int stock,
    required String category, 
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
          productName: productName,
          productDescription: productDescription,
          sizes: sizes,
          price: price,
          stock: stock,
          uploadImages: imageUrls, 
          category: category,
          // id: generateRandomId(),
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

//   Future<void> fetchProducts() async {
//   try {
//     final snapshot = await FirebaseFirestore.instance.collection("products").get();
//     products = snapshot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
//     notifyListeners();
//   } catch (e) {
//     print("Error fetching products: $e");
//   }
// }

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true, 
    );
    if (result != null) {
      pickedImages = result.files.map((file) => file.bytes!).toList().cast<Uint8List>();
      print(pickedImages!.length);
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

  void clearPickedImages() {
    pickedImages = null;
    notifyListeners();
  }

  // // Generate a random ID for each product
  // String generateRandomId() {
  //   final Random random = Random();
  //   return 'product_${random.nextInt(10000)}';
  // }
}
