import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/models/categories/categories.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/models/users/users.dart';

class AdminController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getUsers() async {
    // get all users as  list of user we used this method in report screen / adminside ,

    List<Users> users = [];
    try {
      await firestore.collection("users").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          users.add(Users(
            id: element.id.toString(),
            name: element.get('name'),
            rule: element.get('rule'),
            gender: element.get('gender'),
            group: element.get('group'),
            imageUrl: element.get('imageurl'),
            password: element.get('password'),
          ));
        });
      });
      return users;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<List<Categories>> getcategories() async {
    // get categories we used this method in report screen / adminside
    List<Categories> categories = [];
    try {
      await firestore.collection("categories").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          categories.add(Categories(
            id: element.id.toString(),
            name: element.get('name'),
          ));
        });
      });
      return categories;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future getproducts() async {
    // get products we used this method in report screen / adminside

    List<Products> products = [];
    try {
      await firestore.collection("products").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          products.add(Products(
              type: element.get('type'),
              price: element.get('price'),
              qty: element.get('quantity'),
              url: element.get('url'),
              name: element.get('name'),
              id: element.id.toString()));
        });
      });
      return products;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
