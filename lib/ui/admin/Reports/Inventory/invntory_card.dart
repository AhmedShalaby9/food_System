import 'package:flutter/material.dart';
import 'package:garson_app/models/products/products.dart';

Widget inventoryCard({Products products}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: ListTile(
        title: Text(products.name),
        trailing: Text(products.qty.toString()),
      ),
    ),
  );
}
