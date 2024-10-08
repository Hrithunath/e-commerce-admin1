import 'package:e_commerce_admin/model/catergoryshoe.dart';
import 'package:e_commerce_admin/view_model/provider/provider/size.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/editproduct.dart';
import 'package:e_commerce_admin/views/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/product.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Future.microtask(
        () => Provider.of<ProductShoe>(context, listen: false).fetchProducts());

    final categoryShoe = Provider.of<CategoryShoe>(context);
    final sizes = Provider.of<SizeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          text: "Product List",
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                                  TextCustom(text: "sizes"),
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
                        child: Consumer<ProductShoe>(
                          builder: (context, productShoe, child) {
                            if (productShoe.products.isEmpty) {
                              return Center(
                                child: TextCustom(
                                  text: "No products available",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: productShoe.products.length,
                                itemBuilder: (context, index) {
                                  final product = productShoe.products[index];
                                  
                                  final category =
                                      categoryShoe.categories.firstWhere(
                                    (cat) => cat.id == product.category,
                                    orElse: () => CategoryModel(
                                      id: 'default-id',
                                      categoryName: 'Default Category',
                                      imageUrl: '',
                                    ),
                                  );

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            TextCustom(text: "${index + 1}"),
                                            SizedBox(
                                              height: 50,
                                              width: 40,
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: (product.uploadImages !=
                                                            null &&
                                                        product.uploadImages
                                                            .isNotEmpty)
                                                    ? Image.network(
                                                        product.uploadImages[0],
                                                        height:
                                                            screenHeight * 0.05,
                                                        width:
                                                            screenWidth * 0.04,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            height:
                                                                screenHeight *
                                                                    0.05,
                                                            width: screenWidth *
                                                                0.04,
                                                            color: Colors.red,
                                                            child: const Center(
                                                              child: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Container(
                                                        height:
                                                            screenHeight * 0.05,
                                                        width:
                                                            screenWidth * 0.04,
                                                        color: Colors.amber,
                                                        child: const Center(
                                                          child: Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            TextCustom(
                                                text: product.productName),
                                            TextCustom(
                                                text: category?.categoryName ??
                                                    "No Category"),
                                            TextCustom(
                                                text: product.sizes.join(',')),
                                            TextCustom(
                                                text: product.stock.toString()),
                                            TextCustom(
                                                text:
                                                    '₹${product.price.toString()}'),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditProduct(
                                                                  productId:
                                                                      product
                                                                          .id)),
                                                    );
                                                  },
                                                  icon: const Icon(Icons.edit),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    showAlertDialog(
                                                        context,
                                                        "Remove Product",
                                                        "Do you want to delete this Product?",
                                                        () =>  Provider.of<ProductShoe>(
                                                            context,
                                                            listen: false)
                                                        .deleteProduct(
                                                            product.id) 
                                                        );
                                                   
                                                  },
                                                  icon: const Icon(Icons.delete),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
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
