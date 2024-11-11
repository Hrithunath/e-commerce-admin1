import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/firebase_options.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/category.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/banner.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/order.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/product.dart';
import 'package:e_commerce_admin/view_model/provider/provider/sidebar.dart';
import 'package:e_commerce_admin/view_model/provider/provider/size.dart';
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
        ChangeNotifierProvider(create: (_) => Banneres()),
        ChangeNotifierProvider(create: (_) => SizeProvider()),
        ChangeNotifierProvider(create: (_) => Orders()),
        ChangeNotifierProvider(
          create: (_) => SidebarProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SideBar());
  }
}
