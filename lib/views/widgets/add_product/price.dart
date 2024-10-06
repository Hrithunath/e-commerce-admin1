
import 'package:e_commerce_admin/utils/validator/validator.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:e_commerce_admin/views/widgets/textformfeild.dart';
import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.screenHeight,
    required this.priceController,
  });

  final double screenHeight;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          TextCustom(text: "Price", fontSize: 17),
          SizedBox(height: screenHeight * 0.01),
          Textformfeildcustom(
            label: "",
            backgroundcolor: Colors.white,
            controller: priceController,
            keyboardType: TextInputType.number,
              validator: (value) => Validator.validateProductName(value)
          ),
        ],
      ),
    );
  }
}
