
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
               Center(child: TextCustom(text: "Category Management",
               fontSize: 22,
                fontWeight: FontWeight.w900,)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                TextCustom(text: "Category Management",
                fontSize: 22,
                fontWeight: FontWeight.w700,),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Textformfeildcustom(label: "Type here"),
                ),
                SizedBox(width: screenWidth * 0.02),
                ButtonCustomized(text: "Add Category", onPressed: (){},color:Color.fromARGB(255, 192, 42, 219),),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  color: Colors.grey,
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.2,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 33),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                     padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenHeight * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.04,
                          color: Colors.amber,
                        ),
                        title: TextCustom(text: "Formals",
                        fontSize: 14,color: Colors.black,),
                        trailing: Wrap(
                          spacing: 8.0,
                          children: [
                           ButtonCustomized(text: "Edit", onPressed: (){},color: const Color.fromARGB(255, 192, 42, 219),),
                            ButtonCustomized(text: "Delete", onPressed: (){}),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
