class ProductModel {
  final String id; 
  final String productName;
  final String productDescription;
  final List<String> sizes; 
  final double price;
  final int stock;
  final List<String> uploadImages; 
  final String category;
  final bool isNewArrival;      
  final bool isTopCollection;   

  ProductModel({
    required this.id, 
    required this.productName,
    required this.productDescription,
    required this.sizes,
    required this.price,
    required this.stock,
    required this.uploadImages,
    required this.category,
    required this.isNewArrival,
    required this.isTopCollection,
  });

  
  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'productName': productName,
      'productDescription': productDescription,
      'sizes': sizes,
      'price': price,
      'stock': stock,
      'uploadImages': uploadImages,
      'category': category,
      'isNewArrival': isNewArrival,
      'isTopCollection': isTopCollection,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'], // Fetching the id
      productName: json['productName'],
      productDescription: json['productDescription'],
      sizes: List<String>.from(json['sizes'] ?? []),
      price: json['price'],
      stock: json['stock'],
      uploadImages: List<String>.from(json['uploadImages'] ?? []),
      category: json['category'],
      isNewArrival: json['isNewArrival'] ?? false, 
      isTopCollection: json['isTopCollection'] ?? false,
    );
  }
}
