import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:flutter/material.dart';

class productList extends StatelessWidget {
  const productList({super.key});

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
            SizedBox(height: screenHeight * 0.03,),
            SizedBox(
              height: 18,
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                        TextCustom(text: "Sl NO"),
                        TextCustom(text: "Name"),
                        TextCustom(text: "Product Name"),
                        TextCustom(text: "Category"),
                        TextCustom(text: "Stock"),
                        TextCustom(text: "Status"),
                        TextCustom(text: "Actions"),
                      ],
                    ),
                 
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                       return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          TextCustom(text: "Stock"),
                          TextCustom(text: "Stock"),
                          TextCustom(text: "Stock"),
                          TextCustom(text: "Stock"),
                          TextCustom(text: "Stock"),
                          TextCustom(text: "Stock"),
                          TextCustom(text: "Stock"),
                         ],
                       );
                      }),
                )
                 ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
