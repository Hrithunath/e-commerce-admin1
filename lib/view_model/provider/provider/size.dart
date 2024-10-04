import 'package:flutter/foundation.dart';

class SizeProvider extends ChangeNotifier {
   List<String>selectedSize=[];


  void selectionSize(String size){
    if (selectedSize.contains(size)) {
      selectedSize.remove(size);
    }else{
      selectedSize.add(size);
    }
    notifyListeners();
  }

  void setSelectedSize(List<String>sizes){
    selectedSize.clear();
    selectedSize.addAll(sizes);
    notifyListeners();
  }

  void clearSize(){
    selectedSize.clear();
    notifyListeners();
  }
}