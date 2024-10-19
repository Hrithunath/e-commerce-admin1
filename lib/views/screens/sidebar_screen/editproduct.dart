
import 'package:e_commerce_admin/model/product.dart';
import 'package:e_commerce_admin/view_model/provider/provider/size.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/product.dart';
import 'package:e_commerce_admin/views/widgets/add_product/dropdown_widget.dart';
import 'package:e_commerce_admin/views/widgets/add_product/size_widget.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/scaffold_message.dart';

import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String productId;

  const EditProduct({super.key, required this.productId});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late final ProductModel product;
  late final CategoryShoe categoryShoe;
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final productShoe = Provider.of<ProductShoe>(context, listen: false);
    product = await productShoe
        .getProductById(widget.productId); // Assuming this is an async method

    // Now set the controller texts if the product is fetched
    if (product != null) {
      productNameController.text = product!.productName;
      productDescriptionController.text = product.productDescription;
      priceController.text = product.price.toString();
      stockController.text = product.stock.toString();

      // Set selected size and category
      Provider.of<SizeProvider>(context, listen: false)
          .setSelectedSize(product.sizes);
      Provider.of<CategoryShoe>(context, listen: false)
          .setCategory(product.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final productShoe = Provider.of<ProductShoe>(context);
    final formKey = GlobalKey<FormState>();

    if (product == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: TextCustom(
                          text: "Edit Product",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.9,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 204, 199, 199),
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
                              // Product Name Field
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide the Product Name.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              // Product Description Field
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide the Product Description.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              // Size Selection
                              const TextCustom(
                                text: "Size",
                                color: Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              const SizeSelectionWidget(),
                              SizedBox(height: screenHeight * 0.02),
                              // Price and Stock Section
                              const TextCustom(
                                text: "Price and Stock",
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TextCustom(text: "Price", fontSize: 17),
                                        SizedBox(height: screenHeight * 0.01),
                                        Textformfeildcustom(
                                          label: "",
                                          backgroundcolor: Colors.white,
                                          controller: priceController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please provide the Price.';
                                            } else if (double.tryParse(value) ==
                                                    null ||
                                                double.parse(value) <= 0) {
                                              return 'Please provide a valid positive number for Price.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  // Stock Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TextCustom(text: "Stock", fontSize: 17),
                                        SizedBox(height: screenHeight * 0.01),
                                        Textformfeildcustom(
                                          label: "",
                                          backgroundcolor: Colors.white,
                                          controller: stockController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please provide the stock.';
                                            } else if (int.tryParse(value) ==
                                                    null ||
                                                int.parse(value) < 0) {
                                              return 'Please provide a valid non-negative number for Stock.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // New Arrival Checkbox
                              CheckboxListTile(
                                title: const Text("New Arrival"),
                                value: productShoe.isNewArrival,
                                onChanged: (bool? value) {
                                  productShoe.toggleNewArrival();
                                },
                              ),
                              // Top Collection Checkbox
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
                      SizedBox(height: screenHeight * 0.02),
                      // Save Button
                      Center(
                        child: ButtonCustomized(
                          text: "Save",
                          height: screenHeight * 0.05,
                          color: const Color.fromARGB(255, 192, 42, 219),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              // Check if the form is valid
                              final selectedSizes = Provider.of<SizeProvider>(
                                      context,
                                      listen: false)
                                  .selectedSize;
                              final categoryShoe = Provider.of<CategoryShoe>(
                                  context,
                                  listen: false); // No assignment

                              if (selectedSizes.isEmpty) {
                                showSnackBarMessage(
                                    context, "Please select at least one size.",
                                    backgroundColor: Colors.red);
                                return;
                              }

                              // // Check if at least one image is uploaded
                              // if (productShoe.pickedImages == null || productShoe.pickedImages!.isEmpty) {
                              //   showSnackBarMessage(context, "Please upload at least one image.", backgroundColor: Colors.red);
                              //   return;
                              // }

                              // Check if a category is selected
                              if (categoryShoe.selectedCategory == null ||
                                  categoryShoe.selectedCategory == 'Unknown') {
                                showSnackBarMessage(
                                    context, "Please select a category.",
                                    backgroundColor: Colors.red);
                                return;
                              }

                              final double? price =
                                  double.tryParse(priceController.text);
                              final int stock =
                                  int.tryParse(stockController.text) ?? 0;

                              try {
                                await productShoe.editProduct(
                                    product, categoryShoe,
                                    productName: productNameController.text,
                                    description:
                                        productDescriptionController.text,
                                    price: price!,
                                    stock: stock,
                                    selectedSizes: selectedSizes,
                                    uploadNewImages: true);

                                // Clear fields after successful update
                                productNameController.clear();
                                productDescriptionController.clear();
                                priceController.clear();
                                stockController.clear();

                                // Navigate back or show a success message
                                Navigator.of(context).pop();
                              } catch (error) {
                                print("Error updating product: $error");
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.09),
                    child: Container(
                      height: screenHeight * 0.8,
                      width: screenWidth * 0.9,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 204, 199, 199),
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
                                          fit: BoxFit.cover,
                                        )
                                      : (product.uploadImages.isNotEmpty
                                          ? Image.network(
                                              product.uploadImages[0],
                                              fit: BoxFit.cover,
                                            )
                                          : const Center(
                                              child: Text("No Image Selected"),
                                            )),
                                ),
                                IconButton(
                                  onPressed: () => productShoe.pickImages(),
                                  icon: const Icon(
                                    Icons.add,
                                    size: 33,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(
                              height: screenHeight * 0.1,
                              child: CarouselView(
                                scrollDirection: Axis.horizontal,
                                itemExtent: screenWidth * 0.06,
                                children: List.generate(
                                  (productShoe.pickedImages?.length ?? 0) +
                                      product
                                          .uploadImages.length, // Total count
                                  (index) {
                                    if (index <
                                        (productShoe.pickedImages?.length ??
                                            0)) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.symmetric(horizontal: 8),
                                        color: Colors.white,
                                        child: Image.memory(
                                          productShoe.pickedImages![index],
                                          fit: BoxFit.cover,
                                          width: screenWidth * 0.2,
                                          height: screenHeight * 0.2,
                                        ),
                                      );
                                    } else {
                                      int uploadIndex = index -
                                          (productShoe.pickedImages?.length ??
                                              0);
                                      if (uploadIndex <
                                          product.uploadImages.length) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          color: Colors.white,
                                          child: Image.network(
                                            product.uploadImages[uploadIndex],
                                            fit: BoxFit.cover,
                                            width: screenWidth * 0.2,
                                            height: screenHeight * 0.2,
                                          ),
                                        );
                                      } else {
                                        return const SizedBox
                                            .shrink(); // For safety, return empty space for any extra indexes
                                      }
                                    }
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
