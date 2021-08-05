import 'package:equatable/equatable.dart';
import 'package:garson_app/models/users/users.dart';

abstract class AuthenticationStates extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Appstart extends AuthenticationStates {}

class Initializedasadmin extends AuthenticationStates {
  final Users users;
  final bool isAdmin;
  Initializedasadmin({this.isAdmin, this.users});
}

class Initializedasuser extends AuthenticationStates {
  final Users users;
  final bool isuser;
  Initializedasuser({this.isuser, this.users});
}

class Initializedasgarconextend extends AuthenticationStates {
  final Users users;
  final bool isgarcon;
  Initializedasgarconextend({this.isgarcon, this.users});
}

class FirstOppen extends AuthenticationStates {}

class Unintialized extends AuthenticationStates {}

class NotIntialized extends AuthenticationStates {}
