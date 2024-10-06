class Validator{

  static String? validateProductName(String? value){
    if(value == null || value.isEmpty){
      return 'Please provide the Product Name.';
    }
    return null;
  }


  static String? validateProductDescription(String? value){
    if(value == null || value.isEmpty){
      return 'Please provide the Product Description';
    }
    return null;
  }

  static String? validateProductPrice(String? value){
    if(value == null || value.isEmpty){
      return 'Please provide the Product Price.';
    }
    return null;
  }

  static String? validateProductStock(String? value){
    if(value == null || value.isEmpty){
      return 'Please provide the Product Stock.';
    }
    return null;
  }


  static String? validateCategory(String? value){
    if(value == null || value.isEmpty){
      return 'Please provide the Category Name.';
    }
    return null;
  }
























}