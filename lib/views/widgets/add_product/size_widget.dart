
import 'package:e_commerce_admin/view_model/provider/size.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeSelectionWidget extends StatelessWidget {
  const SizeSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeProvider = Provider.of<SizeProvider>(context);
    final List<String> ShoeSizes =["6","7","8","9"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(ShoeSizes.length, (index) {
          String size = ShoeSizes[index];
          bool isSelected = sizeProvider.selectedSize.contains(size);
          return GestureDetector(
            onTap: () {
              sizeProvider.selectionSize(size);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: isSelected ? Colors.grey : Colors.white,
                radius: 27,
                child: TextCustom(
                  text: size,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
