import 'package:flutter/material.dart';
import 'package:garson_app/models/orders/orders.dart';

import 'order_detailsScreen.dart';

class ItemOderCard extends StatelessWidget {
  final Orders orders;
  final int number;
  ItemOderCard({@required this.orders, this.number});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return OrderDetails(
            orders: orders,
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(right: 12, left: 12, top: 10, bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Text(
                  "Order status :",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(orders.order_status,
                    style: TextStyle(
                      color: Colors.red[900],
                    ))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Text("Name: ", style: Theme.of(context).textTheme.bodyText1),
                Text(
                  orders.member_name,
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 1,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Text("Group: ", style: Theme.of(context).textTheme.bodyText1),
                Text(
                  orders.group,
                  style: Theme.of(context).textTheme.subtitle2,
                  maxLines: 1,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(
                  width: 6,
                ),
                Text("Date & time : ",
                    style: Theme.of(context).textTheme.bodyText1),
                Text(orders.datetime,
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
