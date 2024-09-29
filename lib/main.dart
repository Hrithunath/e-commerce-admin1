import 'package:e_commerce_admin/firebase_options.dart';
import 'package:e_commerce_admin/provider/category.dart';
import 'package:e_commerce_admin/provider/product.dart';
import 'package:e_commerce_admin/provider/sidebar.dart';
import 'package:e_commerce_admin/provider/size.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
 

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    
       MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryShoe()),
        ChangeNotifierProvider(create: (_) => ProductShoe()),
        ChangeNotifierProvider(create: (_) => SizeProvider()),
        ChangeNotifierProvider(create: (_) => SidebarProvider(),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Sidebar()  
      );
  }
  
}
