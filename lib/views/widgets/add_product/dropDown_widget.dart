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
        color: Colors.white, 
        border: Border.all(color: Colors.grey), 
        borderRadius: BorderRadius.circular(5), 
      ),
      child: DropdownButton<String>(
        hint: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Select Category",
            style: TextStyle(color: Colors.grey), 
          ),
        ),
        value: categoryShoe.selectedCategory, 
        onChanged: (String? newValue) {
          print("values:$newValue");
          if (newValue != null) {
            categoryShoe.selectCategory(newValue);
          }
        },
        items: categoryShoe.categories.map<DropdownMenuItem<String>>((CategoryModel category) {
          return DropdownMenuItem<String>(
            value: category.id, 
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                category.categoryName, 
                style: const TextStyle(color: Colors.black), 
              ),
            ),
          );
        }).toList(),
        isExpanded: true, 
        style: const TextStyle(color: Colors.black), 
        dropdownColor: Colors.white, 
      ),
    );
  }
}
