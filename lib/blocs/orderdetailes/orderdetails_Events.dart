import 'package:flutter/cupertino.dart';
import 'package:garson_app/models/orders/orders.dart';

abstract class OrderDetaisEvents {}

class IncreaseSugar extends OrderDetaisEvents {}

class DicreaseSugar extends OrderDetaisEvents {}

class MakeOrder extends OrderDetaisEvents {
  final Orders orders;
  final String id;
  final int qty;
  MakeOrder({@required this.orders, @required this.id, @required this.qty});
}
