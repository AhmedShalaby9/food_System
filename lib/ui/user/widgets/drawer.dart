import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garson_app/blocs/userInfo/UserInfo_bloc.dart';
import 'package:garson_app/blocs/userInfo/bloc.dart';
import 'package:garson_app/ui/auth/login_screen.dart';
import 'package:garson_app/ui/user/profile/profile_Screen.dart';
import 'package:garson_app/ui/user/userOrders/User_Orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DraWer extends StatefulWidget {
  final String id;

  DraWer({this.id});
  @override
  _DraWerState createState() => _DraWerState();
}

class _DraWerState extends State<DraWer> {
  UserInfoBloc userInfoBloc = new UserInfoBloc(InitialStates());

  @override
  void initState() {
    userInfoBloc.add(FetchUserInfo(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print(userInfoBloc.state.toString());
    return BlocProvider(
        create: (BuildContext context) {
          return userInfoBloc;
        },
        child: BlocBuilder(
          cubit: userInfoBloc,
          builder: (BuildContext context, state) {
            if (state is InitialStates) {
              return Drawer(
                child: Center(
                  child: Text("loading....."),
                ),
              );
            } else if (state is FetchUserInfoSuccess) {
              return Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserAccountsDrawerHeader(
                        accountEmail: Text(state.user.first.group),
                        accountName: Text(state.user.first.name),
                        currentAccountPicture: state.user.first.imageUrl ==
                                'null'
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).buttonColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 35.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: CachedNetworkImage(
                                  imageUrl: state.user.first.imageUrl,
                                  fit: BoxFit.fitHeight,
                                  placeholder: (context, url) => Center(
                                      child: SpinKitThreeBounce(
                                    size: 25.0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).buttonColor),
                                      );
                                    },
                                  )),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                ),
                              ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ProfileScreen();
                          }));
                        },
                        child: new ListTile(
                          title: Text("My Profile"),
                          leading: Icon(Icons.person,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            userInfoBloc.add(FetchUserInfo());
                            return UserOrders(
                              name: state.user.first.name,
                            );
                          }));
                        },
                        child: new ListTile(
                          title: Text("My Orders"),
                          leading: Icon(Icons.category,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(
                      //         builder: (BuildContext context) {
                      //       userInfoBloc.add(FetchUserInfo());
                      //       return UserOrders(
                      //         name: state.user.first.name,
                      //       );
                      //     }));
                      //   },
                      //   child: new ListTile(
                      //     title: Text("Last Orders"),
                      //     leading: Icon(Icons.category,
                      //         color: Theme.of(context).primaryColor),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () async {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return LoginScreen();
                          }), (Route<dynamic> route) => false);
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.clear();
                        },
                        child: new ListTile(
                          title: Text("Log Out"),
                          leading: Icon(Icons.logout,
                              color: Theme.of(context).buttonColor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Text("Error");
            }
          },
        ));
  }
}
