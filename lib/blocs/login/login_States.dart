import 'package:garson_app/models/users/users.dart';

abstract class LoginStates {}

class InitialStates extends LoginStates {}

class LoginSuccess extends LoginStates {
  final Users users;
  final bool isAdmin;
  final bool isManage;
  final bool isuser;
  LoginSuccess({this.isAdmin, this.users, this.isManage, this.isuser});
}

class LoginFailled extends LoginStates {
  final String errormsg;
  LoginFailled({this.errormsg});
}

class WaitingToLogin extends LoginStates {}
