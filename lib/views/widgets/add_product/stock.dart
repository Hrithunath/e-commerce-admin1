
import 'package:e_commerce_admin/utils/validator/validator.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';

class Stock extends StatelessWidget {
  const Stock({
    super.key,
    required this.screenHeight,
    required this.stockController,
  });

  final double screenHeight;
  final TextEditingController stockController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          TextCustom(text: "Stock", fontSize: 17),
          SizedBox(height: screenHeight * 0.01),
          Textformfeildcustom(
            label: "",
            backgroundcolor: Colors.white,
            controller: stockController,
            keyboardType: TextInputType.number,
             validator: (value) => Validator.validateProductName(value)
          ),
        ],
      ),
    );
  }
}
