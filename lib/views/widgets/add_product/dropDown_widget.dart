import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart'; // Import your CategoryShoe provider
import 'package:e_commerce_admin/model/catergoryshoe.dart'; // Make sure to import your CategoryModel

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
  });

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    final categoryShoe = Provider.of<CategoryShoe>(context);

    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the container
        border: Border.all(color: Colors.grey), // Border color
        borderRadius: BorderRadius.circular(5), // Rounded corners
      ),
      child: DropdownButton<String>(
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Select Category",
            style: TextStyle(color: Colors.grey), // Hint text color
          ),
        ),
        value: categoryShoe.selectedCategory, // Current selected category
        onChanged: (String? newValue) {
          print("values:$newValue");
          if (newValue != null) {
            categoryShoe.selectCategory(newValue); // Update selected category
            setState(() {
              categoryShoe.selectedCategory = newValue;
            });
          }
        },
        items: categoryShoe.categories.map<DropdownMenuItem<String>>((CategoryModel category) {
          return DropdownMenuItem<String>(
            value: category.id, // Assuming 'id' is the field holding the category ID
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                category.categoryName, // Display the category name
                style: const TextStyle(color: Colors.black), // Text color for category name
              ),
            ),
          );
        }).toList(),
        isExpanded: true, // Make the dropdown take the full width
        style: const TextStyle(color: Colors.black), // Text color for the selected item
        dropdownColor: Colors.white, // Background color of the dropdown menu
      ),
    );
  }
}
