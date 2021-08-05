import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/models/users/users.dart';

class UserController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getUserdata({String id}) async {
    // get user data as list of user ............
    List<Users> users = [];
    try {
      await firestore.collection("users").doc(id).get().then((snapshot) {
        users.add(Users(
            gender: snapshot.get('gender'),
            imageUrl: snapshot.get('imageurl'),
            group: snapshot.get('group'),
            name: snapshot.get('name'),
            password: snapshot.get('password'),
            rule: snapshot.get('rule'),
            id: snapshot.id.toString()));
      });

      return users;
    } catch (e) {
      print("error");
    }
  }

  Future getordersUsingFfilter({@required var date, @required username}) async {
    // get orders list using filter date using date  >>>>>>>>>>>>>>>>>>>>>>>>
    List<Orders> orders = [];
    try {
      await firestore.collection("orders").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          element.get('date') == date && element.get('member_name') == username
              ? orders.add(Orders(
                  date: element.get('date'),
                  price: element.get('price'),
                  id: element.id.toString(),
                  url: element.get('url'),
                  addtions: element.get('addtions'),
                  quantity: element.get('quantity'),
                  group: element.get('group'),
                  member_name: element.get('member_name'),
                  order_name: element.get('order_name'),
                  order_status: element.get('order_status'),
                  datetime: element.get('datetime')))
              : Container(
                  child: Text("No Items"),
                );
        });
      });
      return orders;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
