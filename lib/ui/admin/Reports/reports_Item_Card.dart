import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget menuItemCard(
    {IconData iconData, String name, BuildContext context, var ontab}) {
  return InkWell(
    onTap: ontab,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: PhysicalModel(
        shape: BoxShape.rectangle,
        shadowColor: Theme.of(context).buttonColor,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Icon(
              iconData,
              color: Theme.of(context).buttonColor,
              size: 30,
            ),
            new SizedBox(
              height: 20.0,
            ),
            new Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
        color: Colors.grey[200],
      ),
    ),
  );
}
