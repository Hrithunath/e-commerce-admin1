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
