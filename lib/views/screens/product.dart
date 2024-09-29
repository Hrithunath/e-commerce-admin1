import 'package:e_commerce_admin/provider/category.dart';
import 'package:e_commerce_admin/provider/product.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final productShoe = Provider.of<ProductShoe>(context);
    final categoryShoe = Provider.of<CategoryShoe>(context);
    return 
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: TextCustom(
                text: "Product List",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 222, 219, 219),
              height: screenHeight * 0.9,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.green,
                        ),
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  TextCustom(text: "Sl NO"),
                                  TextCustom(text: "Image"),
                                  TextCustom(text: "Product Name"),
                                  TextCustom(text: "Category"),
                                  TextCustom(text: "Stock"),
                                  TextCustom(text: "Price"),
                                  TextCustom(text: "Actions"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: productShoe.products.length,
                          itemBuilder: (context, index) {
                            final product = productShoe.products[index];
                            final category = categoryShoe.categories.isNotEmpty
                                ? categoryShoe.categories[index]
                                : null;

                            return Table(
                              children: [
                                TableRow(
                                  children: [
                                    TextCustom(text: "${index + 1}"),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: (product.uploadImages != null &&
                                                product
                                                    .uploadImages!.isNotEmpty)
                                            ? Image.network(
                                                product.uploadImages![0],
                                                height: screenHeight * 0.05,
                                                width: screenWidth * 0.04,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    height: screenHeight * 0.05,
                                                    width: screenWidth * 0.04,
                                                    color: Colors.red,
                                                    child: const Center(
                                                        child: Icon(Icons.error,
                                                            color:
                                                                Colors.white)),
                                                  );
                                                },
                                              )
                                            : Container(
                                                height: screenHeight * 0.05,
                                                width: screenWidth * 0.04,
                                                color: Colors.amber,
                                                child: const Center(
                                                    child: Icon(Icons.image,
                                                        color: Colors.white)),
                                              ),
                                      ),
                                    ),
                                    TextCustom(
                                        text: product.productName ??
                                            "Unknown Product"),
                                    TextCustom(
                                        text: category?.categoryName ??
                                            "No Category"),
                                    TextCustom(
                                        text:
                                            product.stock?.toString() ?? "N/A"),
                                    TextCustom(
                                        text:
                                            product.price?.toString() ?? "N/A"),
                                    TextCustom(text: "Actions"),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    
  }
}
