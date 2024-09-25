import 'package:e_commerce_admin/provider/category.dart';
import 'package:e_commerce_admin/view_models/catergoryshoe.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key});

  final categoryController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final categoryShoe = Provider.of<CategoryShoe>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: TextCustom(
                      text: "Category Management",
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Textformfeildcustom(
                    label: "Type here",
                    controller: categoryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Category is required";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                ButtonCustomized(
                  text: "Add Category",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      if (categoryShoe.pickedImage != null) {
                        final imageUrl = await categoryShoe.uploadImage();
                        final category = CategoryModel(
                          categoryName: categoryController.text,
                          imageUrl: imageUrl,
                          id: DateTime.now().millisecondsSinceEpoch.toString(), // Use unique ID
                        );
                        await categoryShoe.createCategory(category as String);
                        categoryController.clear();
                        categoryShoe.clearPickedImage();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an image')),
                        );
                      }
                    }
                  },
                  color: const Color.fromARGB(255, 192, 42, 219),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  color: Colors.grey,
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.2,
                  child: categoryShoe.pickedImage != null
                      ? Image.memory(categoryShoe.pickedImage!)
                      : const Center(child: Text("No Image Selected")),
                ),
                IconButton(
                  onPressed: () => categoryShoe.pickImage(),
                  icon: const Icon(Icons.add, size: 33),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: categoryShoe.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryShoe.categories[index];
                  if (category.imageUrl == null || category.categoryName.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: category.imageUrl.isNotEmpty
                            ? Image.network(
                                category.imageUrl,
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.04,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.04,
                                    color: Colors.red,
                                    child: const Center(
                                      child: Icon(Icons.error, color: Colors.white),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.04,
                                color: Colors.amber,
                                child: const Center(child: Icon(Icons.image, color: Colors.white)),
                              ),
                        title: TextCustom(
                          text: category.categoryName,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        trailing: Wrap(
                          spacing: 8.0,
                          children: [
                            ButtonCustomized(
                              text: "Edit",
                              onPressed: () {},
                              color: const Color.fromARGB(255, 192, 42, 219),
                            ),
                            ButtonCustomized(text: "Delete", onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

