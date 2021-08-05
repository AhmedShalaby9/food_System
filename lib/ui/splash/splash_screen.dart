import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/authentication/authentication_Events.dart';
import 'package:garson_app/blocs/authentication/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  void getdeviceTToken() async {
    var devicetoken = await firebaseMessaging.getToken();
    print("token :$devicetoken");
  }

  @override
  void initState() {
    getdeviceTToken();
    Future.delayed(Duration(seconds: 5), () {
      BlocProvider.of<AuthenticationBloc>(context).add(IsFirstOppen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        'assets/gif_logo.gif',
      )),
    );
  }
}
