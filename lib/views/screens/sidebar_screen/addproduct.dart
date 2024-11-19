import 'package:e_commerce_admin/utils/validator/validator.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/product.dart';
import 'package:e_commerce_admin/view_model/provider/provider/size.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/drawer.dart';
import 'package:e_commerce_admin/views/widgets/add_product/dropdown_widget.dart';
import 'package:e_commerce_admin/views/widgets/add_product/price.dart';
import 'package:e_commerce_admin/views/widgets/add_product/stock.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/add_product/size_widget.dart';
import 'package:e_commerce_admin/views/widgets/scaffold_message.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final productShoe = Provider.of<ProductShoe>(context);
    final categoryShoe = Provider.of<CategoryShoe>(context);
    final sizeProvider = Provider.of<SizeProvider>(context);
    final formkey = GlobalKey<FormState>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: TextCustom(
                        text: "Upload Product",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),

                      //========= General Information Section =========
                      Container(
                        width: screenWidth * 0.9,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 226, 220, 220),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenHeight * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextCustom(
                                text: "General Information",
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              //========= Product Name Field =========
                              const TextCustom(
                                text: "Product Name",
                                color: Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),

                              Textformfeildcustom(
                                label: "",
                                backgroundcolor: Colors.white,
                                controller: productNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) =>
                                    Validator.validateProductName(value),
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              //========= Product Description Field =========
                              const TextCustom(
                                text: "Product Description",
                                color: Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),

                              Textformfeildcustom(
                                  maxLines: 6,
                                  label: "",
                                  backgroundcolor: Colors.white,
                                  controller: productDescriptionController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) =>
                                      Validator.validateProductDescription(
                                          value)),
                              SizedBox(height: screenHeight * 0.02),

                              //========= Size Selection Widget =========
                              const TextCustom(
                                text: "Size",
                                color: Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              const SizeSelectionWidget(),
                              SizedBox(height: screenHeight * 0.02),

                              //========= Price and Stock Section =========
                              const TextCustom(
                                text: "Price and Stock",
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                              SizedBox(height: screenHeight * 0.02),

                              //========= Price and Stock input fields side by side =========
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Price(
                                      screenHeight: screenHeight,
                                      priceController: priceController),
                                  SizedBox(width: screenWidth * 0.05),
                                  Stock(
                                      screenHeight: screenHeight,
                                      stockController: stockController),
                                ],
                              ),
                              //========= Checkbox for New Arrival =========
                              CheckboxListTile(
                                title: const Text("New Arrival"),
                                value: productShoe.isNewArrival,
                                onChanged: (bool? value) {
                                  productShoe.toggleNewArrival();
                                },
                              ),

                              //========= Checkbox for Top Collection =========
                              CheckboxListTile(
                                title: const Text("Top Collection"),
                                value: productShoe.isTopCollection,
                                onChanged: (bool? value) {
                                  productShoe.toggleTopCollection();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      //========= Submit Button =========
                      SizedBox(height: screenHeight * 0.02),
                      Center(child: Consumer<ProductShoe>(
                          builder: (context, productShoe, child) {
                        return ButtonCustomized(
                            text: "Add Product",
                            height: screenHeight * 0.05,
                            color: Colors.blue,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                //========= Check if sizes are selected =========
                                final selectedSizes = Provider.of<SizeProvider>(
                                        context,
                                        listen: false)
                                    .selectedSize;
                                if (selectedSizes.isEmpty) {
                                  showSnackBarMessage(context,
                                      "Please select at least one size.",
                                      backgroundColor: Colors.red);
                                  return;
                                }

                                //========= Check if product images are selected =========

                                if (productShoe.pickedImages == null ||
                                    productShoe.pickedImages!.isEmpty) {
                                  showSnackBarMessage(context,
                                      "Please upload at least one image.",
                                      backgroundColor: Colors.red);
                                  return;
                                }

                                //========= Check if a category is selected =========

                                if (categoryShoe.selectedCategory == null ||
                                    categoryShoe.selectedCategory ==
                                        'Unknown') {
                                  showSnackBarMessage(
                                      context, "Please select a category.",
                                      backgroundColor: Colors.red);
                                  return;
                                }

                                final copiedSizes =
                                    List<String>.from(selectedSizes);
                                final double? price =
                                    double.tryParse(priceController.text);
                                final int stock =
                                    int.tryParse(stockController.text) ?? 0;

                                productShoe.createProduct(
                                  productName: productNameController.text,
                                  productDescription:
                                      productDescriptionController.text,
                                  sizes: copiedSizes,
                                  price: price!,
                                  stock: stock,
                                  category: categoryShoe.selectedCategory ??
                                      'Unknown',
                                  categoryNames: categoryShoe.getCategoryName(
                                      categoryShoe.selectedCategory ??
                                          'Unknown'),
                                  isNewArrival: productShoe.isNewArrival,
                                  isTopCollection: productShoe.isTopCollection,
                                );

                                productNameController.clear();
                                productDescriptionController.clear();
                                priceController.clear();
                                stockController.clear();
                                if (!context.mounted) return;
                                Provider.of<SizeProvider>(context,
                                        listen: false)
                                    .clearSize();
                                productShoe.clearPickedImages();
                                productShoe.resetCheckboxes();
                                categoryShoe.clearCategory();

                                showSnackBarMessage(
                                    context, 'Product added successfully!',
                                    backgroundColor: Colors.green);

                                pageController.jumpToPage(1);
                              }
                            });
                      })),
                    ],
                  ),
                ),
                //========= Right side for image upload section =========
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.09),
                    child: Container(
                      height: screenHeight * 0.8,
                      width: screenWidth * 0.9,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 226, 220, 220),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenHeight * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextCustom(
                              text: "Upload image",
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              children: [
                                Container(
                                  color: Colors.white,
                                  height: screenHeight * 0.3,
                                  width: screenWidth * 0.2,
                                  child: productShoe.pickedImages != null &&
                                          productShoe.pickedImages!.isNotEmpty
                                      ? Image.memory(
                                          productShoe.pickedImages![0],
                                        )
                                      : const Center(
                                          child: Text("No Image Selected")),
                                ),
                                IconButton(
                                    onPressed: () => productShoe.pickImages(),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 33,
                                    )),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(
                              height: screenHeight * 0.1,
                              child: CarouselView(
                                scrollDirection: Axis.horizontal,
                                itemExtent: screenWidth * 0.06,
                                children: List.generate(
                                  productShoe.pickedImages?.length ?? 0,
                                  (int index) {
                                    return Container(
                                      color: Colors.white,
                                      child: productShoe.pickedImages != null &&
                                              productShoe
                                                  .pickedImages!.isNotEmpty
                                          ? Image.memory(
                                              productShoe.pickedImages![index],
                                            )
                                          : const Center(
                                              child: Text("No Image Selected"),
                                            ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.07),
                            const TextCustom(
                              text: "Category",
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            const TextCustom(
                              text: "Product Category",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            const DropDownWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
