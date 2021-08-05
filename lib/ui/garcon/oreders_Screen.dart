import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/controller/garcon_controller.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'itemorder_card.dart';

Garconcontroller garconcontroller = new Garconcontroller();

class GarconOrdersScreen extends StatefulWidget {
  @override
  _GarconOrdersScreenState createState() => _GarconOrdersScreenState();
}

class _GarconOrdersScreenState extends State<GarconOrdersScreen> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void configureMessageing() {
    firebaseMessaging.configure(
        onResume: (message) async {
          print("onResume : $message");
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return GarconOrdersScreen();
          }));
        },
        onMessage: (message) async {},
        onLaunch: (message) async {});
  }

  @override
  void initState() {
    super.initState();

    configureMessageing();
    adminSideBloc.add(FetchOrders(orderType: 'pending'));
    adminSideBloc.add(SaveToken());
  }

  AdminSideBloc adminSideBloc = new AdminSideBloc();

  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Orders',
          style: Theme.of(context).appBarTheme.textTheme.bodyText1,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: garconcontroller.getstream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Orders> orders = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                if (data['order_status'] == 'pending')
                  orders.add(Orders(
                      time: data['time'],
                      id: doc.id.toString(),
                      addtions: data['addtions'],
                      datetime: data['datetime'],
                      group: data['group'],
                      member_name: data['member_name'],
                      order_name: data['order_name'],
                      order_status: data['order_status'],
                      quantity: data['quantity'],
                      url: data['url']));
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return ItemOderCard(
                    orders: orders,
                    index: index,
                    number: index + 1,
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          }),
    );
  }
}
