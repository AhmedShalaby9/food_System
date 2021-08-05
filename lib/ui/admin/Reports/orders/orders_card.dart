import 'package:flutter/material.dart';
import 'package:garson_app/models/orders/orders.dart';

Widget ordersCard({Orders orders}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
        elevation: 1.1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13.0), topRight: Radius.circular(13))),
        child: ListTile(
          title: Text(orders.member_name),
          leading: Text(orders.order_name),
          subtitle: Text(orders.group),
          trailing: Text(orders.datetime),
        )),
  );
}
