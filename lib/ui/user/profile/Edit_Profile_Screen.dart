import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/userInfo/bloc.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/models/users/users.dart';
import 'package:image_picker/image_picker.dart';

Controller controller = new Controller();

class EditProfile extends StatefulWidget {
  final List<Users> user;
  EditProfile({@required this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  var newName, newPassword;
  UserInfoBloc userInfoBloc = new UserInfoBloc(InitialStates());
  final picker = ImagePicker();
  File _imageSelcted;
  String _imageurl;
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) {
        return userInfoBloc;
      },
      child: BlocConsumer(
        cubit: userInfoBloc,
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            return Fluttertoast.showToast(msg: 'done');
          }
        },
        builder: (BuildContext context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          }
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (formkey.currentState.validate()) {
                    formkey.currentState.save();

                    userInfoBloc.add(UpdateProfile(
                        id: widget.user.first.id,
                        imagepath: _imageSelcted,
                        user: Users(
                          name: newName,
                          password: newPassword,
                        )));
                  }
                },
                child: Text("Submit"),
              ),
            ),
            appBar: AppBar(
              title: Text(
                "Edit Profile",
                style: Theme.of(context).appBarTheme.textTheme.bodyText1,
              ),
              centerTitle: true,
            ),
            body: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: _height * 0.1,
                    ),
                    widget.user.first.imageUrl == 'null'
                        ? Center(
                            child: InkWell(
                                onTap: () async {
                                  final pickedFile = await picker.getImage(
                                      source: ImageSource.gallery);

                                  setState(() {
                                    if (pickedFile != null) {
                                      _imageSelcted = File(pickedFile.path);
                                    } else {
                                      print('No image selected.');
                                    }
                                  });
                                },
                                child: _imageSelcted == null
                                    ? new Image.asset('assets/addpicc.png')
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image.file(
                                          _imageSelcted,
                                          height: 200,
                                        ),
                                      )))
                        : Center(
                            child: Container(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Stack(children: [
                                  _imageSelcted != null
                                      ? Image.file(_imageSelcted)
                                      : CachedNetworkImage(
                                          imageUrl: widget.user.first.imageUrl,
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
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 170.0),
                                    child: InkWell(
                                      onTap: () async {
                                        final pickedFile =
                                            await picker.getImage(
                                                source: ImageSource.gallery);

                                        setState(() {
                                          if (pickedFile != null) {
                                            _imageSelcted =
                                                File(pickedFile.path);
                                          } else {
                                            print('No image selected.');
                                          }
                                        });
                                      },
                                      child: new Icon(
                                        Icons.add_a_photo,
                                        size: 27,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                    new SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.edit), labelText: "Name"),
                          onSaved: (savedname) {
                            print(savedname);
                            return newName = savedname;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter Your name , Please";
                            }
                          },
                          initialValue: widget.user.first.name,
                        )),
                    new SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock), labelText: "Password"),
                          onSaved: (savedpassword) {
                            print(savedpassword);
                            return newPassword = savedpassword;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Enter Your password , Please";
                            }
                          },
                          initialValue: widget.user.first.password,
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
