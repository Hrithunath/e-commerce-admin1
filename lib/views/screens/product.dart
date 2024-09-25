import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
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
                                  TextCustom(text: "Status"),
                                  TextCustom(text: "Actions"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 150,
                          itemBuilder: (context, index) {
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
                                        child: Image.network(
                                                                        "https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/78b1c276-1a6e-4048-a5c8-6f8d1747e837/PEGASUS+PLUS.png",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                          return  Text(
                                            'Error loading image${error}',
                                            style: TextStyle(color: Colors.red),
                                          );
                                        }),
                                      ),
                                    ),
                                   
                                    TextCustom(text: "Product Name"),
                                    TextCustom(text: "Category"),
                                    TextCustom(text: "Stock"),
                                    TextCustom(text: "Status"),
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
      ),
    );
  }
}
