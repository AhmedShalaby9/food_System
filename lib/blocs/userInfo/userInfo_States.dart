import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/models/users/users.dart';

class UserInfoStates {}

class FetchUserInfoSuccess extends UserInfoStates {
  final List<Users> user;
  FetchUserInfoSuccess({this.user});
}

class InitialStates extends UserInfoStates {}

class LoadingState extends UserInfoStates {}

class UpdateProfileSuccess extends UserInfoStates {}

class OnExption extends UserInfoStates {
  final String errormsg;
  OnExption({this.errormsg});
}

class FetchUserOrdersSuccess extends UserInfoStates {
  final Orders orders;
  FetchUserOrdersSuccess({this.orders});
}
