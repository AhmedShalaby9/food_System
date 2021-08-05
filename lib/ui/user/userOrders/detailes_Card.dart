import 'package:flutter/material.dart';
import 'package:garson_app/models/orders/orders.dart';

Widget detailesCard({BuildContext context, Orders orders, var length}) {
  var _height = MediaQuery.of(context).size.height;
  var _width = MediaQuery.of(context).size.width;
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(
                "Number of orders : ",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                length,
                style: TextStyle(color: Theme.of(context).buttonColor),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Number of orders : ",
          //       style: Theme.of(context).textTheme.bodyText1,
          //     ),
          //     Text(
          //       '',
          //       style: TextStyle(color: Theme.of(context).buttonColor),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     Text(
          //       "Number of orders : ",
          //       style: Theme.of(context).textTheme.bodyText1,
          //     ),
          //     Text(
          //       "test",
          //       style: TextStyle(color: Theme.of(context).buttonColor),
          //     ),
          //   ],
          // ),
        ],
      ),
    ),
    height: _height * 0.05,
    width: _width,
  );
}
