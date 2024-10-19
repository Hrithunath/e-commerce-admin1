import 'package:e_commerce_admin/utils/validator/validator.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:e_commerce_admin/views/widgets/add%20category/ShowModel_edit_button.dart';
import 'package:e_commerce_admin/views/widgets/add%20category/add_category_button.dart';
import 'package:e_commerce_admin/views/widgets/alert.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({
    super.key,
  });

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
                      validator: (value) => Validator.validateCategory(value)),
                ),
                SizedBox(width: screenWidth * 0.02),
                ButtonCustomized(
                  text: "Add Category",
                  onPressed: () async {
                    await Addcat(categoryShoe, context);
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
                  if (category.imageUrl == null ||
                      category.categoryName.isEmpty) {
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
                                      child: Icon(Icons.error,
                                          color: Colors.white),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                height: screenHeight * 0.05,
                                width: screenWidth * 0.04,
                                color: Colors.amber,
                                child: const Center(
                                    child:
                                        Icon(Icons.image, color: Colors.white)),
                              ),
                        title: TextCustom(
                          text: category.categoryName,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        trailing: Wrap(
                          spacing: 8.0,
                          children: [
                            ShowModelBottomSheetEditButton(
                                category: category, formkey: formkey),
                            ButtonCustomized(
                              text: "Delete",
                              color: const Color.fromARGB(255, 192, 42, 219),
                              onPressed: () {
                                showAlertDialog(
                                    context,
                                    "Remove Category",
                                    "Do you want to delete this category?",
                                    () => categoryShoe
                                        .deleteCategory(category.id));
                              },
                            )
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
