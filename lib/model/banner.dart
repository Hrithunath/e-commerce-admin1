import 'package:flutter/foundation.dart';

class BannerModel {
  
  String id;
  String imageUrl;

  BannerModel({
    required this.id,
   required this.imageUrl,
  });

  Map<String,dynamic>toJson(){
   
   return{
    "bannerid":id,
    "imageurl":imageUrl,
   };
  }

  factory BannerModel.fromJson(Map<String,dynamic>json){

return BannerModel( id: json['id'] ?? '',
    imageUrl: json['imageurl'] ?? '',
 );
  }
}