import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/models/groups/groups.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:path/path.dart' as path;

class Controller {
  //              get data from firestore.........................
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Future getorders(
      {@required var ordertype, bool cuurentuser, String username}) async {
    // get orders list using order status as pending or deliverd >>>>>>>>>>>>>>>
    List<Orders> orders = [];
    try {
      await firestore.collection("orders").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          if (cuurentuser == true) {
            // here we can get specif orders using user name ,
            element.get('order_status') == ordertype &&
                    element.get('member_name') == username
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
                : Container();
          } else {
            // in this case we get all orders using order staus only.......
            element.get('order_status') == ordertype
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
                : Container();
          }
        });
      });
      return orders;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future getdataList({var collection, type}) async {
    // get data from firestore as List...........
    List<Products> products = [];
    List<Groups> groups = [];
    List<Orders> orders = [];
    try {
      await firestore.collection("$collection").get().then((snapshot) {
        snapshot.docs.forEach((element) {
          collection == 'products' && element.get('type') == type
              ? products.add(Products(
                  type: element.get('type'),
                  price: element.get('price'),
                  qty: element.get('quantity'),
                  url: element.get('url'),
                  name: element.get('name'),
                  id: element.id.toString()))
              : collection == 'groups'
                  ? groups.add(Groups(
                      id: element.id.toString(),
                      name: element.get('name'),
                      users: element.get('users')))
                  : collection == 'orders' &&
                          element.get('order_status') == 'pending'
                      ? orders.add(Orders(
                          id: element.id.toString(),
                          url: element.get('url'),
                          addtions: element.get('addtions'),
                          quantity: element.get('quantity'),
                          group: element.get('group'),
                          member_name: element.get('member_name'),
                          order_name: element.get('order_name'),
                          order_status: element.get('order_status'),
                          datetime: element.get('datetime')))
                      : print('error');
        });
      });
      return collection == 'products'
          ? products
          : collection == 'groups'
              ? groups
              : collection == 'orders'
                  ? orders
                  : '';
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future uploadimage({var imagpath}) async {
    // upload images to firebase storage........
    FirebaseStorage storage = FirebaseStorage.instance;
    var imageurl;
    Reference reference =
        storage.ref().child('products/${path.basename(imagpath.path)}');
    UploadTask storageUploadTask = reference.putFile(imagpath);

    await storageUploadTask.whenComplete(() async {
      var uRL = await storage
          .ref(storageUploadTask.snapshot.ref.fullPath)
          .getDownloadURL();
      imageurl = uRL;
    });
    return imageurl;
  }

  updateData({var collection, data, id}) async {
    /// update data .///////////
    var result = firestore.collection(collection).doc(id).update(data);
    return result;
  }

  deletemember({String id, username, array}) async {
    // delete user from group...//...//...//...//....
    var result = await firestore.collection('groups').doc(id).update({
      username: FieldValue.arrayRemove([array])
    });
    return result;
  }

  addmember({String id, fieldname, array}) async {
    // add new user to group..///...//../././.
    var result = await firestore.collection('groups').doc(id).update({
      fieldname: FieldValue.arrayUnion([array])
    });
    return result;
  }

  adddata({@required collection, @required var data}) async {
    // add data to firestore..//..//..//..//..//..//..//..
    var result = await firestore.collection(collection).add(data);
    return result;
  }

  deletedata({String collection, String id}) async {
    // delete data ../.../././..//
    var result = await firestore.collection('$collection').doc(id).delete();

    return result;
  }
}
