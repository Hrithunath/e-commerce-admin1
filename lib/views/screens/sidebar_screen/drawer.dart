import 'package:e_commerce_admin/views/screens/sidebar_screen/dashboard.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/order.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/addproduct.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/addcategory.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/banner.dart';
import 'package:e_commerce_admin/views/screens/sidebar_screen/product.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

PageController pageController = PageController();

class _SideBarState extends State<SideBar> {
  SideMenuController sideMenuController = SideMenuController();

  @override
  void dispose() {
    sideMenuController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: sideMenuController,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.open,
              hoverColor: Colors.blue[100],
              selectedColor: Colors.blue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              unselectedTitleTextStyle: const TextStyle(color: Colors.black),
              unselectedIconColor: Colors.black,
            ),
            title: const Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Admin',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            items: [
              SideMenuItem(
                title: 'Dash Board',
                icon: const Icon(Icons.dashboard),
                onTap: (index, _) {
                  pageController.jumpToPage(0);
                  sideMenuController.changePage(0);
                },
              ),
              SideMenuItem(
                title: 'Upload Product',
                icon: const Icon(Icons.upload_rounded),
                onTap: (index, _) {
                  pageController.jumpToPage(1);
                  sideMenuController.changePage(1);
                },
              ),
              SideMenuItem(
                title: 'Product ',
                icon: const Icon(Icons.shop_rounded),
                onTap: (index, _) {
                  pageController.jumpToPage(2);
                  sideMenuController.changePage(2);
                },
              ),
              SideMenuItem(
                title: 'Order',
                icon: const Icon(Icons.shopping_cart),
                onTap: (index, _) {
                  pageController.jumpToPage(3);
                  sideMenuController.changePage(3);
                },
              ),
              SideMenuItem(
                title: 'Category',
                icon: const Icon(Icons.category_sharp),
                onTap: (index, _) {
                  pageController.jumpToPage(4);
                  sideMenuController.changePage(4);
                },
              ),
              SideMenuItem(
                title: 'Banner',
                icon: const Icon(Icons.photo_size_select_actual_rounded),
                onTap: (index, _) {
                  pageController.jumpToPage(5);
                  sideMenuController.changePage(5);
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                sideMenuController.changePage(index);
              },
              children: [
                Dashboard(),
                AddProduct(),
                const ProductList(),
                OrderList(),
                const AddCategory(),
                const AdminBanner(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
