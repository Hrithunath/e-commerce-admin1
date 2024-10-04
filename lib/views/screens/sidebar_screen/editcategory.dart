// import 'package:e_commerce_admin/model/catergoryshoe.dart';
// import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
// import 'package:e_commerce_admin/views/widgets/text.dart';
// import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
// import 'package:flutter/material.dart';

// class Editcategory extends StatelessWidget {
//   final GlobalKey<FormState> formkey;
//   final TextEditingController categoryController;
//   final CategoryShoe categoryShoe;
//   final CategoryModel category; // The category to edit

//   const Editcategory({
//     super.key,
//     required this.formkey,
//     required this.categoryController,
//     required this.categoryShoe,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Populate the controller with the current category name
//     categoryController.text = category.categoryName;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Category"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Form(
//               key: formkey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: screenHeight * 0.02),
//                   Center(
//                     child: TextCustom(
//                       text: "Category Management",
//                       fontSize: 22,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Textformfeildcustom(
//                           label: "Edit category name",
//                           controller: categoryController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Category is required";
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       SizedBox(width: screenWidth * 0.02),
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (formkey.currentState!.validate()) {
//                             // Check if a new image was selected
//                             String? imageUrl = category.imageUrl;
//                             if (categoryShoe.pickedImage != null) {
//                               imageUrl = await categoryShoe.uploadImage(); // Upload new image if selected
//                             }

//                             final updatedCategory = CategoryModel(
//                               categoryName: categoryController.text,
//                               imageUrl: imageUrl!,
//                               id: category.id, // Retain the same ID
//                             );

//                             await categoryShoe. editCategory(updatedCategory); // Update the category

//                             // Clear the controller and image
//                             categoryController.clear();
//                             categoryShoe.clearPickedImage();

//                             Navigator.pop(context); // Close the editing screen
//                           }
//                         },
//                         child: const Text("Update Category"),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                   Row(
//                     children: [
//                       Container(
//                         color: Colors.grey[300],
//                         height: screenHeight * 0.15,
//                         width: screenWidth * 0.2,
//                         child: categoryShoe.pickedImage != null
//                             ? Image.memory(categoryShoe.pickedImage!) // New image selected
//                             : category.imageUrl.isNotEmpty // Show existing image if no new image selected
//                                 ? Image.network(category.imageUrl)
//                                 : const Center(child: Text("No Image Selected")),
//                       ),
//                       IconButton(
//                         onPressed: () => categoryShoe.pickImage(),
//                         icon: const Icon(Icons.add, size: 33),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
