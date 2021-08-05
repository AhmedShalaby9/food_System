import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Login extends LoginEvents {}
