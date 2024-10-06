import 'package:e_commerce_admin/model/catergoryshoe.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:flutter/material.dart';
final categoryController = TextEditingController();
 final GlobalKey<FormState> formkey = GlobalKey<FormState>();
 
Future<void> Addcat(CategoryShoe categoryShoe, BuildContext context) async {
    if (formkey.currentState!.validate()) {
      if (categoryShoe.pickedImage != null) {
        final imageUrl = await categoryShoe.uploadImage();
        final category = CategoryModel(
          categoryName: categoryController.text,
          imageUrl: imageUrl,
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        );
        await categoryShoe
            .createCategory(category.categoryName);
    
        categoryController.clear();
        categoryShoe.clearPickedImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please select an image')),
        );
      }
    }
  }
