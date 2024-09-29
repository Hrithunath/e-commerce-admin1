import 'package:e_commerce_admin/provider/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_admin/view_models/catergoryshoe.dart'; // Make sure to import your CategoryShoe model

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryShoe = Provider.of<CategoryShoe>(context);

    return Container(
      height: 50,
      width: 250,
      color: Colors.white,
      child: DropdownButton<String>(
        hint: const Text("Select Category", style: TextStyle(color: Colors.grey)),
        value: categoryShoe.selectedCategory,
        onChanged: (String? newValue) {
          if (newValue != null) {
            categoryShoe.setCategory(newValue);
          }
        },
        items: categoryShoe.categories.map<DropdownMenuItem<String>>((CategoryModel category) {
          return DropdownMenuItem<String>(
            value: category.categoryName,
            child: Text(category.categoryName),
          );
        }).toList(),
        isExpanded: true,
        style: const TextStyle(color: Colors.black),
        dropdownColor: Colors.white,
      ),
    );
  }
}
