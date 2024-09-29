import 'package:e_commerce_admin/provider/sidebar.dart';
import 'package:e_commerce_admin/views/screens/addProduct.dart';
import 'package:e_commerce_admin/views/screens/addcategory.dart';
import 'package:e_commerce_admin/views/screens/banner.dart';
import 'package:e_commerce_admin/views/screens/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final sidebarProvider = Provider.of<SidebarProvider>(context);

    return Scaffold(
     
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Dashboard'),
              onTap: () {
                sidebarProvider.selectIndex(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Users'),
              onTap: () {
                sidebarProvider.selectIndex(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Products'),
              onTap: () {
                sidebarProvider.selectIndex(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Orders'),
              onTap: () {
                sidebarProvider.selectIndex(3);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Category'),
              onTap: () {
                sidebarProvider.selectIndex(4);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Upload Product'),
              onTap: () {
                sidebarProvider.selectIndex(5);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Upload Banner'),
              onTap: () {
                sidebarProvider.selectIndex(6);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: sidebarProvider.selectedIndex,
        children: [
          
           ProductList(),
          
           AddCategory(),
          AddProduct(),
           AdminBanner()
        ],
      ),
    );
  }
}