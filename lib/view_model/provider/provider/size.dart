import 'package:flutter/foundation.dart';

class SizeProvider extends ChangeNotifier {
  final List<String> selectedSize = [];

  // Toggle selection of a size
  void selectionSize(String size) {
    bool changed = false;

    if (selectedSize.contains(size)) {
      selectedSize.remove(size);
      print("Removed size: $size");
      changed = true;
    } else {
      selectedSize.add(size);
      print("Added size: $size");
      changed = true;
    }

    if (changed) {
      print("Current selected sizes: $selectedSize");
      notifyListeners();
    }
  }

  // Set multiple sizes and remove duplicates
  void setSelectedSize(List<String> sizes) {
    final newSizes =
        sizes.where((size) => !selectedSize.contains(size)).toList();

    if (newSizes.isNotEmpty) {
      selectedSize.clear();
      selectedSize.addAll(newSizes);

      print("Set selected sizes: $selectedSize");
      notifyListeners();
    }
  }

  // Clear the selected sizes
  void clearSize() {
    if (selectedSize.isNotEmpty) {
      selectedSize.clear();
      print("Cleared selected sizes.");
      notifyListeners();
    }
  }
}
