import 'package:e_commerce_admin/views/screens/product.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: SingleChildScrollView(
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
                            ),
                            SizedBox(height: screenHeight * 0.02),
                
                            // Size Selection
                            TextCustom(
                              text: "Size",
                              color: const Color.fromARGB(255, 112, 111, 111),
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(10, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      radius: 27,
                                      child: TextCustom(
                                        text: (index + 7).toString(),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextCustom(
                              text: "Price and Stock",
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextCustom(text: "Price", fontSize: 17),
                                      SizedBox(height: screenHeight * 0.01),
                                      Textformfeildcustom(
                                        label: "",
                                        backgroundcolor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.05),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextCustom(text: "Stock", fontSize: 17),
                                      SizedBox(height: screenHeight * 0.01),
                                      Textformfeildcustom(
                                        label: "",
                                        backgroundcolor: Colors.white,
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
                       child: ButtonCustomized(text:"Add Product",
                       height: screenHeight*0.05,
                               color: const Color.fromARGB(255, 192, 42, 219), 
                               onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>const ProductList()));
                               }),
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
                    height: screenHeight *0.8,
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
                                ),
                                IconButton(onPressed: (){}, icon: const Icon(Icons.add,size: 33,)),
                              ],
                            ),
                             SizedBox(height: screenHeight * 0.02),
                           SizedBox(
                            height: screenHeight * 0.1,
                             child: CarouselView(itemExtent: screenWidth * 0.06,
                              children: List.generate(10,(int index){
                              return Container(
                                color: Colors.white
                              );
                             }),),
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
                            Container(
                              
                              height: 50,
                              width: 250,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  const Spacer(),
                                  IconButton(onPressed: (){},
                                   icon: const Icon(Icons.arrow_drop_down_outlined)),
                                ],
                              ),
                            ),

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
