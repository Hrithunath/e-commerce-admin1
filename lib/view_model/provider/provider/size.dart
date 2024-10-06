import 'package:flutter/foundation.dart';

class SizeProvider extends ChangeNotifier {
  final List<String> selectedSize = [];

  void selectionSize(String size) {
    if (selectedSize.contains(size)) {
      selectedSize.remove(size);
      print("Removed size: $size");
    } else {
      selectedSize.add(size);
      print("Added size: $size");
    }
    print("Current selected sizes: $selectedSize");
    notifyListeners();
  }

  void setSelectedSize(List<String> sizes) {
    
    selectedSize.clear();
    selectedSize.addAll(sizes.where((size) => !selectedSize.contains(size)));
    
    print("Set selected sizes: $selectedSize");
    notifyListeners();
  }

  void clearSize() {
    selectedSize.clear();
    print("Cleared selected sizes.");
    notifyListeners();
  }
}
