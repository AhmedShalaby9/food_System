import 'package:flutter/cupertino.dart';

abstract class OrderDetaisStates {}

class IntialStates extends OrderDetaisStates {}

class IncreaseSuccssed extends OrderDetaisStates {
  final String quantity;
  IncreaseSuccssed({this.quantity});
}

class DicreaseSuccssed extends OrderDetaisStates {
  final String quantity;
  DicreaseSuccssed({this.quantity});
}

class MakeOrderSuccess extends OrderDetaisStates {}

class MakeOrderFailled extends OrderDetaisStates {
  final String errormsg;
  MakeOrderFailled({@required this.errormsg});
}
