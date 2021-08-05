import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/login/login_Events.dart';
import 'package:garson_app/blocs/login/login_States.dart';
import 'package:garson_app/blocs/login/login_bloc.dart';
import 'package:garson_app/ui/admin/admin.dart';
import 'package:garson_app/ui/garcon/oreders_Screen.dart';
import 'package:garson_app/ui/splash/splash_screen.dart';
import 'package:garson_app/ui/user/menu/menu_Screen.dart';

import '../../consts.dart';
import 'package:garson_app/controller/api_controller.dart';

Controller controller = new Controller();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  LoginBloc bloc = new LoginBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) {
          return bloc;
        },
        child: BlocConsumer(
          cubit: bloc,
          listener: (BuildContext context, state) {
            if (state is LoginSuccess) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return state.isAdmin == true
                    ? AdminHomePage()
                    : state.isManage == true
                        ? GarconOrdersScreen()
                        : state.isuser == true
                            ? HomeScreen(
                                data: state.users,
                              )
                            : SplashScreen();
              }), (Route<dynamic> route) => false);
            } else if (state is LoginFailled) {
              Fluttertoast.showToast(msg: state.errormsg);
            } else if (state is WaitingToLogin) {}
          },
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Container(
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 50.0),
                      )),
                      height: _height * 0.44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(200.0)),
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: _width,
                      height: _height * 0.05,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter your name";
                            }
                          },
                          controller: namecontroller,
                          decoration:
                              InputDecoration(hintText: "Enter your name"),
                        )),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter your password";
                            }
                          },
                          controller: passwordcontroller,
                          decoration:
                              InputDecoration(hintText: "Enter your password"),
                        )),
                    SizedBox(
                      height: _height * 0.04,
                    ),
                    Container(
                      width: _width * 0.5,
                      child: state is WaitingToLogin
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : FlatButton(
                              color: Theme.of(context).buttonColor,
                              child: Text("login"),
                              onPressed: () async {
                                if (globalKey.currentState.validate()) {
                                  bloc.add(Login());
                                }
                              },
                            ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
