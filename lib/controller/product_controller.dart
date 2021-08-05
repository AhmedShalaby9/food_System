import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/models/products/products.dart';

class ProductController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getproductsUsingtype({@required var producttype}) async {
    // in this method we fetching products using product type as drinks or snacks >>>
    List<Products> products = [];
    try {
      await firestore.collection("products").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          element.get('type') == producttype
              ? products.add(Products(
                  type: element.get('type'),
                  price: element.get('price'),
                  qty: element.get('quantity'),
                  url: element.get('url'),
                  name: element.get('name'),
                  id: element.id.toString()))
              : Container(
                  child: Text(
                    "nullll",
                    style: TextStyle(color: Colors.red),
                  ),
                );
        });
      });
      return products;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
