import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garson_app/models/orders/orders.dart';

Widget userOrderCard({BuildContext context, Orders orders, var width}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.0,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          shadowColor: Theme.of(context).buttonColor,
          child: Column(
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      orders.order_name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    width: width,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(orders.datetime),
              )
            ],
          ),
          elevation: 1,
        ),
      ));
}
