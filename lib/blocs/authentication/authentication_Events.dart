import 'package:equatable/equatable.dart';

abstract class AuthenticationEvents extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AppStart extends AuthenticationEvents {}

class IsFirstOppen extends AuthenticationEvents {}

class LoggedIn extends AuthenticationEvents {}

class LoggedOut extends AuthenticationEvents {}
