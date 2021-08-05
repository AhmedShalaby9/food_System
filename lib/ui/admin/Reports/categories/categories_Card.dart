import 'package:flutter/material.dart';
import 'package:garson_app/models/categories/categories.dart';

Widget categoriescard({Categories categories, var ontab}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: ListTile(
        title: Text(categories.name),
        trailing: InkWell(onTap: ontab, child: Icon(Icons.delete)),
      ),
    ),
  );
}
