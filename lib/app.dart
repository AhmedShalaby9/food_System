import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/ui/auth/login_screen.dart';
import 'package:garson_app/ui/garcon/oreders_Screen.dart';
import 'package:garson_app/ui/splash/splash_screen.dart';
import 'package:garson_app/ui/user/menu/menu_Screen.dart';
import 'blocs/authentication/authentication_.States.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'ui/admin/admin.dart';

Controller controller;
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final roundBorderRadius = BorderRadius.circular(12);
  final primarycolor = Color(0xff0D294C);
  final secondaryColor = Color(0xffEC7503);
  // ignore: close_sinks
  AuthenticationBloc bloc = AuthenticationBloc();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) {
          return bloc;
        },
        child: MaterialApp(
          title: "Break",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: BlocBuilder(
            builder: (BuildContext context, state) {
              print(state.toString());
              if (state is Appstart) {
                return SplashScreen();
              } else if (state is FirstOppen) {
                return LoginScreen();
              } else if (state is Initializedasadmin) {
                return AdminHomePage();
              } else if (state is Initializedasuser) {
                return HomeScreen();
              } else if (state is Initializedasgarconextend) {
                return GarconOrdersScreen();
              } else if (state is NotIntialized) {
                return LoginScreen();
              } else {
                return null;
              }
            },
            cubit: bloc,
          ),
          theme: ThemeData(
              dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  titleTextStyle: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  elevation: 0.0,
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              textTheme: TextTheme(
                  headline2: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800),
                  headline1: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800),
                  headline3: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800]),
                  headline5: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[800]),
                  headline4: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                  bodyText1: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w800)),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16,
                ),
                errorStyle: TextStyle(color: Colors.red.shade700),
//            labelStyle: inputTheme.labelStyle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: roundBorderRadius,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                  borderRadius: roundBorderRadius,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade700),
                  borderRadius: roundBorderRadius,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.red.shade700, width: 1.5),
                  borderRadius: roundBorderRadius,
                ),
              ), // appbar theme ........

              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  )),
                  elevation: 0.0,
                  color: primarycolor),
              buttonTheme: ButtonThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(13.0),
                  ),
                  buttonColor: primarycolor,
                  textTheme: ButtonTextTheme.accent,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 13.0,
                  )),
              accentColor: Colors.white,
              buttonColor: secondaryColor,
              primaryColor: primarycolor),
        ));
  }

  void getdeviceTToken() async {
    var devicetoken = await firebaseMessaging.getToken();
    print("token : $devicetoken");
  }

  void configureMessageing() {
    firebaseMessaging.configure(onResume: (message) async {
      print("onResume : $message");
    }, onMessage: (message) async {
      print("onMessage : $message");
    }, onLaunch: (message) async {
      print("onlaunch : $message");
    });
  }
}
