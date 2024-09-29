class ProductModel {
  String? productName;
  String? productDescription;
  List<String>? sizes; 
  double? price;
  int? stock;
  List<String>? uploadImages; 
  String? category;
  String? productid; 

  
  ProductModel({
    this.productName,
    this.productDescription,
    this.sizes,
    this.price,
    this.stock,
    this.uploadImages,
    this.category,
    this.productid,
  });

  
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productDescription': productDescription,
      'sizes': sizes,
      'price': price,
      'stock': stock,
      'uploadImages': uploadImages,
      'category': category,
      'id': productid,
    };
  }

  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['productName'],
      productDescription: json['productDescription'],
      sizes: List<String>.from(json['sizes'] ?? []),
      price: json['price'],
      stock: json['stock'],
      uploadImages: List<String>.from(json['uploadImages'] ?? []),
      category: json['category'],
      productid: json['id'],
    );
  }
}
