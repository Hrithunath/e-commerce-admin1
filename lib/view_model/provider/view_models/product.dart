import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/product.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductShoe extends ChangeNotifier {
  List<ProductModel> products = [];
  List<Uint8List>? pickedImages;
  bool isLoading = false;

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> createProduct({
    String? id,
    required String productName,
    required String productDescription,
    required List<String> sizes,
    required double price,
    required int stock,
    required String category,
    required String categoryNames,
    required bool isNewArrival,
    required bool isTopCollection,
  }) async {
    // isLoading = true;
    // notifyListeners();
    print("Received sizes: $sizes");
    if (pickedImages != null && pickedImages!.isNotEmpty) {
      try {
        List<String> imageUrls = await uploadImages();

        final product = ProductModel(
          id: id ?? generateRandomId(),
          productName: productName,
          productDescription: productDescription,
          sizes: sizes,
          price: price,
          stock: stock,
          uploadImages: imageUrls,
          category: category,
          categoryNames: categoryNames,
          isNewArrival: isNewArrival,
          isTopCollection: isTopCollection,
        );

        final result = await FirebaseFirestore.instance
            .collection("products")
            .add(product.toJson());

        products.add(product);
        await FirebaseFirestore.instance
            .collection("products")
            .doc(result.id)
            .update({"id": result.id});

        notifyListeners();
        print("Product added with sizes: ${product.sizes}");
      } catch (e) {
        print("Error adding product: $e");
      }
    } else {
      print("Error: No images picked");
    }
    // await fetchProducts();
    // isLoading = false;
  }

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    try {
      print("Fetching products");
      final querySnapshot =
          await FirebaseFirestore.instance.collection("products").get();
      products = querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
      print("Fetched Products: $products");
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(id).delete();
      products.removeWhere((product) => product.id == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Future<void> editProduct(
    ProductModel updatedProduct,
    CategoryShoe categories, {
    required List<String> selectedSizes,
    required int stock,
    required double price,
    required String description,
    required String productName,
    bool uploadNewImages = false,
  }) async {
    try {
      final productIndex =
          products.indexWhere((product) => product.id == updatedProduct.id);
      if (productIndex != -1) {
        List<String> imageUrls = updatedProduct.uploadImages;

        if (uploadNewImages &&
            pickedImages != null &&
            pickedImages!.isNotEmpty) {
          List<String> newImageUrls = await uploadImages();
          imageUrls.addAll(newImageUrls);
        }

        final updated = ProductModel(
          id: updatedProduct.id,
          productName: productName,
          productDescription: description,
          sizes: selectedSizes,
          price: price,
          stock: stock,
          uploadImages: imageUrls,
          category: categories.selectedCategory!,
          categoryNames: categories.selectedCategory!,
          isNewArrival: updatedProduct.isNewArrival,
          isTopCollection: updatedProduct.isTopCollection,
        );

        await FirebaseFirestore.instance
            .collection('products')
            .doc(updated.id)
            .update(updated.toJson());

        products[productIndex] = updated;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  ProductModel getProductById(String id) {
    return products.firstWhere(
      (product) => product.id == id,
      orElse: () {
        throw Exception('Product with ID $id not found');
      },
    );
  }

  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      pickedImages =
          result.files.map((file) => file.bytes!).toList().cast<Uint8List>();
      notifyListeners();
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];
    if (pickedImages != null && pickedImages!.isNotEmpty) {
      for (var image in pickedImages!) {
        try {
          final storageRef = storage.ref().child(
              'productImages/${DateTime.now().millisecondsSinceEpoch}.png');
          UploadTask uploadTask = storageRef.putData(image);
          TaskSnapshot snapshot = await uploadTask;
          String imageUrl = await snapshot.ref.getDownloadURL();

          if (imageUrl.isNotEmpty) {
            imageUrls.add(imageUrl);
          }
        } catch (e) {
          print("Error uploading image: $e");
        }
      }
    }
    return imageUrls;
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
