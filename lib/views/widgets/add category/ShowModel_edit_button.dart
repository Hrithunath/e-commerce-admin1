import 'package:e_commerce_admin/model/catergoryshoe.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowModelBottomSheetEditButton extends StatelessWidget {
  const ShowModelBottomSheetEditButton({
    super.key,
    required this.category,
    required this.formkey,
  });

  final CategoryModel category;
  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return ButtonCustomized(
      text: "Edit",
      onPressed: () {
        final editCategoryController = TextEditingController(
          text: category.categoryName,
        );

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Consumer<CategoryShoe>(
              builder: (context, categoryShoe, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 300,
                            width: 400,
                            color: Colors.grey,
                            child: categoryShoe.pickedImage != null
                                ? Image.memory(
                                    categoryShoe.pickedImage!,
                                    height: 200,
                                    width: 400,
                                    fit: BoxFit.cover,
                                  )
                                : category.imageUrl.isNotEmpty
                                    ? Image.network(
                                        category.imageUrl,
                                        height: 200,
                                        width: 400,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Text("No Image Selected"),
                                      ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await categoryShoe.pickImage();
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Textformfeildcustom(
                        label: "Edit Category Name",
                        controller: editCategoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Category is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ButtonCustomized(
                        text: "Update",
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            final updatedImageUrl =
                                categoryShoe.pickedImage != null
                                    ? await categoryShoe.uploadImage()
                                    : category.imageUrl;

                            final updatedCategory = CategoryModel(
                              categoryName: editCategoryController.text,
                              imageUrl: updatedImageUrl,
                              id: category.id,
                            );

                            await categoryShoe.editCategory(updatedCategory);
                            categoryShoe.clearPickedImage();
                            Navigator.pop(context);
                          }
                        },
                        color: Colors.blue,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      color: Colors.blue,
    );
  }
}
