import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/consts.dart';
import 'package:garson_app/controller/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_Events.dart';
import 'login_States.dart';
import 'package:garson_app/models/users/users.dart';

AuthController authController = new AuthController();

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(InitialStates());
  static LoginBloc get(BuildContext context) => BlocProvider.of(context);

  @override
  Stream<LoginStates> mapEventToState(LoginEvents event) async* {
    if (event is Login) {
      yield WaitingToLogin();
      try {
        List result = await authController.login(
          username: namecontroller.text,
          password: passwordcontroller.text,
        );
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('username', namecontroller.text.toString());
        pref.setString('groupname', result[3].toString());

        yield LoginSuccess(
          users: Users(group: result[3]),
          isAdmin: result[0],
          isuser: result[1],
          isManage: result[2],
        );
      } catch (e) {
        yield LoginFailled(errormsg: e.toString());
      }
    }
  }
}
