
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:flutter/material.dart';

class AdminBanner extends StatelessWidget {
  const AdminBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.5,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                ButtonCustomized(
                  text: "Save",
                  onPressed: () {},
                  color: Colors.blue,
                )
              ],
            ),
             SizedBox(height: screenHeight * 0.02,),
              
            ButtonCustomized(
              text: "Upload Image",
              onPressed: () {},
              color: Colors.blue,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                scrollDirection:Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context,index){
         return     Container(
               width: screenWidth * 0.04,
                  height: screenHeight * 0.5,
                decoration: const BoxDecoration(color: Colors.red),
              );
              
              }),
              
            ),
            
          ]),
        ),
    );
      
    
  }
}
