import 'package:e_commerce_admin/view_model/provider/view_models/banner.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
        child: Consumer<Banneres>(
          builder: (context, banner, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 240, 234, 234),
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.3,
                      child: banner.pickedImage != null
                          ? Image.memory(banner.pickedImage!)
                          : const Center(child: Text("No Image Selected")),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    ButtonCustomized(
                      text: "Save",
                      onPressed: () {
                        // Call the addBanner() method to save the picked image
                        if (banner.pickedImage != null && !banner.isLoading) {
                          banner.addBanner();
                        } else if (banner.pickedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select an image first")),
                          );
                        }
                      },
                      color: Colors.blue,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                ButtonCustomized(
                  text: "Upload Image",
                  onPressed: () {
                    if (!banner.isLoading) {
                      banner.pickImage();
                    }
                  },
                  color: Colors.blue,
                ),
                const Divider(),
                Expanded(
                  child: banner.isLoading
                      ? Center(
                          child: Skeletonizer(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey[
                                  300], // Background color of the skeleton
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                          ),
                        ))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: banner.banneres.length,
                          itemBuilder: (context, index) {
                            final currentBanner = banner.banneres[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.3,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            currentBanner.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      banner.deleteBanner(currentBanner.id);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
