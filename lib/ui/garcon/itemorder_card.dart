import 'package:flutter/material.dart';
import 'package:garson_app/models/orders/orders.dart';

import 'order_detailsScreen.dart';

class ItemOderCard extends StatelessWidget {
  final List<Orders> orders;
  final int number;
  final int index;
  ItemOderCard({@required this.orders, this.number, this.index});
  @override
  Widget build(BuildContext context) {
    // var aDay = new DateTime.now();
    // var berlinWallFell = DateTime.parse((orders[index].datetime.trim()));

    // Duration difference = aDay.difference(berlinWallFell);
    // assert(difference.inDays == 16592);
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return OrderDetails(
            orders: orders[index],
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
                  "Name: ",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                ),
                Flexible(
                  child: Text(orders[index].member_name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      )),
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
                Text("Group: ",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
                Text(
                  orders[index].group,
                  style: TextStyle(
                    fontSize: 22,
                  ),
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
                Text("Time: ",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300)),
                Text(orders[index].time,
                    style: TextStyle(
                      fontSize: 22,
                    ))
              ],
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
