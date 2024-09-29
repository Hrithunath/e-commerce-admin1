import 'package:e_commerce_admin/provider/product.dart';
import 'package:e_commerce_admin/provider/size.dart';
import 'package:e_commerce_admin/views/screens/product.dart';
import 'package:e_commerce_admin/views/widgets/add_product/dropDown_widget.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/size_widget.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final ProductNameController = TextEditingController();
  final ProductDescriptionController = TextEditingController();
  final PriceController = TextEditingController();
  final StockController = TextEditingController();
  final List<String> sizes = [];
  final List<String> selectedImages = [];
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final productShoe = Provider.of<ProductShoe>(context);
    int imagesLength = productShoe.pickedImages?.length ?? 0;
    final formkey = GlobalKey<FormState>();
    return Padding(
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
                      Center(
                          child: TextCustom(
                        text: "Upload Product",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
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
                              TextCustom(
                                text: "General Information",
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              TextCustom(
                                text: "Product Name",
                                color: const Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              Textformfeildcustom(
                                label: "",
                                backgroundcolor: Colors.white,
                                controller: ProductNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide the Product Name.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              TextCustom(
                                text: "Product Description",
                                color: const Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              Textformfeildcustom(
                                label: "",
                                backgroundcolor: Colors.white,
                                height: screenHeight * 0.3,
                                width: screenWidth * 0.9,
                                controller: ProductDescriptionController,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide the Product Description.';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              TextCustom(
                                text: "Size",
                                color: const Color.fromARGB(255, 112, 111, 111),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              SizeSelectionWidget(),
                              SizedBox(height: screenHeight * 0.02),
                              TextCustom(
                                text: "Price and Stock",
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(text: "Price", fontSize: 17),
                                        SizedBox(height: screenHeight * 0.01),
                                        Textformfeildcustom(
                                          label: "",
                                          backgroundcolor: Colors.white,
                                          controller: PriceController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please provide the Price ';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(text: "Stock", fontSize: 17),
                                        SizedBox(height: screenHeight * 0.01),
                                        Textformfeildcustom(
                                          label: "",
                                          backgroundcolor: Colors.white,
                                          controller: StockController,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please provide the stock ';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: ButtonCustomized(
                          text: "Add Product",
                          height: screenHeight * 0.05,
                          color: const Color.fromARGB(255, 192, 42, 219),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              final selectedSizes = Provider.of<SizeProvider>(
                                      context,
                                      listen: false)
                                  .selectedSize;

                              final double price =
                                  double.tryParse(PriceController.text) ?? 0;
                              final int stock =
                                  int.tryParse(StockController.text) ?? 0;

                              productShoe.createProduct(
                                productName: ProductNameController.text,
                                productDescription:
                                    ProductDescriptionController.text,
                                sizes: selectedSizes,
                                price: price,
                                stock: stock,
                                category:
                                    "category", 
                              );

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ProductList(),
                                ),
                              );
                            } else {
                              print("Form is not valid");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.09,
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
                            TextCustom(
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
                                  imagesLength, (int index) {
                                  return Container(color: Colors.white,
                                  child: productShoe.pickedImages != null &&
                                          productShoe.pickedImages!.isNotEmpty
                                      ? Image.memory(
                                          productShoe.pickedImages![index],
                                        )
                                      : const Center(
                                          child: Text("No Image Selected")),);
                                }),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.07),
                            TextCustom(
                              text: "Category",
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextCustom(
                              text: "Product Category",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            DropDownWidget(),
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
      );
    
  }
}
