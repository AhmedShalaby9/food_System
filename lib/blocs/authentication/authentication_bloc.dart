import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/authentication/authentication_.States.dart';
import 'package:garson_app/blocs/authentication/authentication_Events.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc() : super(Appstart());

  @override
  Stream<AuthenticationStates> mapEventToState(
      AuthenticationEvents event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (event is AppStart) {
      yield Appstart();
    } else if (event is IsFirstOppen) {
      if (pref.getBool('isadmin') == true) {
        yield Initializedasadmin();
      } else if (pref.getBool('isuser') == true) {
        yield Initializedasuser();
      } else if (pref.getBool('isgarcon') == true) {
        yield Initializedasgarconextend();
      } else if (pref.getString('username') == null) {
        yield NotIntialized();
      }
    }
  }
}
