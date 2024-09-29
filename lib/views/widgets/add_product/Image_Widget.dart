
// import 'package:e_commerce_admin/views/widgets/add_product/dropDown_widget.dart';
// import 'package:e_commerce_admin/views/widgets/text.dart';
// import 'package:flutter/material.dart';

// class ImageWidget extends StatelessWidget {
//   const ImageWidget({
//     super.key,
//     required this.screenWidth,
//     required this.screenHeight,
//   });

//   final double screenWidth;
//   final double screenHeight;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: screenWidth * 0.09,
//             vertical: screenHeight * 0.09),
//         child: Container(
//           height: screenHeight * 0.8,
//           width: screenWidth * 0.9,
//           decoration: const BoxDecoration(
//             color: Color.fromARGB(255, 204, 199, 199),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.02,
//                 vertical: screenHeight * 0.02),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextCustom(
//                   text: "Upload image",
//                   fontSize: 19,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 Row(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       height: screenHeight * 0.3,
//                       width: screenWidth * 0.2,
//                     ),
//                     IconButton(
//                         onPressed: () {
                          
//                         },
//                         icon: const Icon(
//                           Icons.add,
//                           size: 33,
//                         )),
//                   ],
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 SizedBox(
//                   height: screenHeight * 0.1,
//                   child: CarouselView(
//                     itemExtent: screenWidth * 0.06,
//                     children: List.generate(10, (int index) {
//                       return Container(color: Colors.white);
//                     }),
//                   ),
//                 ),
//                 SizedBox(height: screenHeight * 0.07),
//                 TextCustom(
//                   text: "Category",
//                   fontSize: 19,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 TextCustom(
//                   text: "Product Category",
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.grey,
//                 ),
//                 SizedBox(height: screenHeight * 0.02),
//                 DropDownWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
