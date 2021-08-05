import 'package:flutter/material.dart';
import 'package:garson_app/ui/admin/Reports/users/users_Screen.dart';
import 'Inventory/Inventory.dart';
import 'calculation/calculations.dart';
import 'categories/categories.dart';
import 'groups/groups.dart';
import 'orders/orders_Screen.dart';
import 'reports_Item_Card.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
            children: [
          menuItemCard(
              ontab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return UserScreen();
                }));
              },
              context: context,
              iconData: Icons.person,
              name: 'Users'),
          menuItemCard(
              context: context,
              iconData: Icons.group,
              name: 'Groups',
              ontab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return GroupScreen();
                }));
              }),
          menuItemCard(
              context: context,
              iconData: Icons.store,
              name: 'Inventory',
              ontab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Inventory();
                }));
              }),
          menuItemCard(
              ontab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return CalculationScreen();
                }));
              },
              context: context,
              iconData: Icons.calculate,
              name: 'calculation'),
          menuItemCard(
              context: context,
              iconData: Icons.list_alt_sharp,
              name: 'Orders',
              ontab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return OrdersScreen();
                }));
              }),
          menuItemCard(
              ontab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return CategoriesScreen();
                }));
              },
              context: context,
              iconData: Icons.category,
              name: 'Categories'),
        ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                childAspectRatio: 1.0)));
  }
}
