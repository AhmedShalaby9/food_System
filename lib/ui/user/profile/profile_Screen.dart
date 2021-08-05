import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garson_app/blocs/userInfo/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/userInfo/UserInfo_bloc.dart';
import 'package:garson_app/models/users/users.dart';

import 'Edit_Profile_Screen.dart';

class ProfileScreen extends StatefulWidget {
  final Users user;
  ProfileScreen({this.user});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserInfoBloc userInfoBloc = new UserInfoBloc(InitialStates());

  @override
  void initState() {
    userInfoBloc.add(FetchUserInfo());
    super.initState();
  }

  var username, groupname;
  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) {
        return userInfoBloc;
      },
      child: BlocConsumer(
        listener: (context, state) {},
        cubit: userInfoBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Profile',
                style: Theme.of(context).appBarTheme.textTheme.bodyText1,
              ),
              centerTitle: true,
            ),
            body: BlocConsumer(
              listener: (context, state) {},
              cubit: userInfoBloc,
              builder: (BuildContext context, state) {
                if (state is InitialStates) {
                  return Center(
                      child: SpinKitThreeBounce(
                    size: 50.0,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration:
                            BoxDecoration(color: Theme.of(context).buttonColor),
                      );
                    },
                  ));
                } else if (state is FetchUserInfoSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        new SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 200.0,
                          child: Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: state.user.first.imageUrl == 'null'
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return EditProfile(
                                              user: state.user,
                                            );
                                          }));
                                        },
                                        child: Image.asset(
                                          'assets/addpicc.png',
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: state.user.first.imageUrl,
                                        placeholder: (context, url) => Center(
                                            child: SpinKitThreeBounce(
                                          size: 25.0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .buttonColor),
                                            );
                                          },
                                        )),
                                      )),
                          ),
                        ),
                        new SizedBox(
                          height: 40.0,
                        ),
                        new Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  "${state.user.first.gender ?? ""} : ",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Flexible(
                                  child: new Text(
                                    state.user.first.name ?? "",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ],
                            ),
                            new SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.user.first.group ?? "",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text("loading");
                }
              },
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return EditProfile(
                      user: state.user,
                    );
                  }));
                },
                child: Text("Edit Profile"),
              ),
            ),
          );
        },
      ),
    );
  }
}
