import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garson_app/models/notification/notification.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:http/http.dart' as http;

class Garconcontroller {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var serverkey =
      'AAAAZnjotgg:APA91bESaSsDRKKVV44Z_MShBG355xOwwAl7aejg8xJlH8ZJnS9Ftbe77rkwNRfztOLog9pE32uwY6lwO1g9A8qaa6hE3gqTojariZ7sh0ToI5NFDQyWbSoKvUAMHqSQCRxCCS1elrjH	';
  gettoken() async {
    // get device token to send notification when user proced order............
    var result = await firestore.collection("devicetoken").get();
    print("test : ${result.docs.first.data()['token']}");
    return result.docs.first.data()['token'];
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  notification({var title, body, token}) async {
    // send notification to garcon..................
    http.Response response = await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key = $serverkey"
        },
        body: jsonEncode({
          "to": "$token",
          "notification": {
            "title": "$title",
            "body": "$body",
          }
        }));
    if (response.statusCode == 200) {
      return Notifications.fromJson(jsonDecode(response.body));
    } else {
      print("body" + response.body.toString());
      throw Exception('Failed to send Notification');
    }
  }

  Stream<QuerySnapshot> getstream() {
    // get data from firestore as stream we use it in garcon Screen....
    List<Orders> orders = [];
    var result = firestore.collection('orders').snapshots();
    result.forEach((element) {
      orders.add(Orders(
          date: element.docs.first.get('date'),
          id: element.docs.first.id,
          url: element.docs.first.get('url'),
          addtions: element.docs.first.get('addtions'),
          quantity: element.docs.first.get('quantity'),
          group: element.docs.first.get('group'),
          member_name: element.docs.first.get('member_name'),
          order_name: element.docs.first.get('order_name'),
          order_status: element.docs.first.get('order_status'),
          datetime: element.docs.first.get('datetime')));
    });
    return result;
  }
}
