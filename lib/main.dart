import 'package:e_commerce_admin/firebase_options.dart';
import 'package:e_commerce_admin/views/screens/addcategory.dart';
import 'package:e_commerce_admin/views/screens/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
 

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
     home: productList()  
      );
  }
  
}