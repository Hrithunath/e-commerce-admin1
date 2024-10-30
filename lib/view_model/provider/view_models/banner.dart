import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/model/banner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Banneres extends ChangeNotifier {
  List<BannerModel> banneres = [];
  Uint8List? pickedImage;
  bool isLoading = false;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Banneres() {
    fetchBanner();
  }

 Future<void> addBanner() async {
  isLoading = true;
  notifyListeners();
  try {
    if (pickedImage != null) {
      String imageUrl = await uploadImage();

      if (imageUrl.isNotEmpty) {
        final banner = BannerModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          imageUrl: imageUrl,
        );

        final result = await FirebaseFirestore.instance
            .collection("banner")
            .add(banner.toJson());
        print("Banner added");

        banner.id = result.id;

        await FirebaseFirestore.instance
            .collection("banner")
            .doc(result.id)
            .update({"id": result.id});

        // Clear picked image after upload
        clearPickedImage();

        // Fetch the updated list of banners after adding the new banner
        await fetchBanner(); // Call fetchBanner to refresh the list
      }
    }
  } catch (e) {
    print("Error adding banner: $e");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


  Future<void> fetchBanner() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("banner").get();
      banneres = snapshot.docs.map((doc) {
        final banner = BannerModel.fromJson(doc.data() as Map<String, dynamic>);
        return banner;
      }).toList();
      print("All banners fetched");
      notifyListeners();
    } catch (e) {
      print("Error fetching banners: $e");
    }
  }

  Future<void> deleteBanner(String bannerId) async {
  isLoading = true;
  notifyListeners();
  try {
    // Delete the banner from Firestore
    await FirebaseFirestore.instance.collection("banner").doc(bannerId).delete();

    // Remove the banner from the local list
    banneres.removeWhere((banner) => banner.id == bannerId);
    print("Banner deleted");
  } catch (e) {
    print("Error deleting banner: $e");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      pickedImage = result.files.first.bytes;
      notifyListeners(); // Notify listeners only if an image is picked
    }
  }

  Future<String> uploadImage() async {
    try {
      final storageRef = storage
          .ref()
          .child('bannerImages/${DateTime.now().millisecondsSinceEpoch}.png');
      UploadTask uploadTask = storageRef.putData(pickedImage!);
      TaskSnapshot snapshot = await uploadTask;
      String link = await snapshot.ref.getDownloadURL();
      return link;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }

  void clearPickedImage() {
    pickedImage = null;
    notifyListeners();
  }
}
