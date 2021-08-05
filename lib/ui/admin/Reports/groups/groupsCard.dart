import 'package:flutter/material.dart';
import 'package:garson_app/models/groups/groups.dart';

Widget groupcard(
    {Groups groups, BuildContext context, var onpress, var memberNum}) {
  return Card(
    child: ListTile(
      title: Text(groups.name),
      subtitle: Text(memberNum),
      leading: CircleAvatar(
          backgroundColor: Colors.grey[300], child: Icon(Icons.group)),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onpress,
      ),
    ),
  );
}
