import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garson_app/models/users/users.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget userCard({Users users, BuildContext context, var onpress}) {
  return Card(
    child: ListTile(
      title: Text(users.name),
      subtitle: Text(users.group),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: users.imageUrl != 'null'
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: users.imageUrl,
                  placeholder: (context, imageUrl) => Center(
                      child: SpinKitThreeBounce(
                    size: 10.0,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration:
                            BoxDecoration(color: Theme.of(context).buttonColor),
                      );
                    },
                  )),
                ),
              )
            : Icon(Icons.person, color: Colors.white),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onpress,
      ),
    ),
  );
}
