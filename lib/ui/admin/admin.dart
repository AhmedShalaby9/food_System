import 'package:flutter/material.dart';
import 'package:garson_app/ui/admin/products/products_screen.dart';
import 'package:garson_app/ui/user/menu/menu_Screen.dart';

import 'Reports/reports_screen.dart';
import 'groups/groups_screen.dart';
import 'orders/orders_screen.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int index = 0;
  List _navigatetoScreens = [
    OrdersScreen(),
    ProductsScreen(),
    GroupsScreen(),
    ReportsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomeScreen();
              }));
            },
            icon: Icon(Icons.swap_horiz),
          ),
        ],
        centerTitle: true,
        title: Text(
          index == 0
              ? 'Orders'
              : index == 1
                  ? 'Products'
                  : index == 2
                      ? 'Groups'
                      : 'Reports',
          style: Theme.of(context).appBarTheme.textTheme.bodyText1,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(size: 40.0),
        currentIndex: index,
        onTap: (indexs) {
          setState(() {
            index = indexs;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
        ],
      ),
      body: _navigatetoScreens[index],
    );
  }
}
