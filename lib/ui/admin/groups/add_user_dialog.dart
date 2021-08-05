import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/adminside/adminSide_Bloc.dart';
import 'package:garson_app/blocs/adminside/adminSide_Events.dart';
import 'package:garson_app/models/users/users.dart';

import 'components.dart';

class AddUserDialog extends StatefulWidget {
  final String group;
  final String id;
  AddUserDialog({this.group, this.id});
  @override
  _AddUserDialogState createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  var typevalue, gendervalue;
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  GlobalKey<FormState> addgroupformkey = new GlobalKey<FormState>();
  GlobalKey<FormState> adduserformkey = new GlobalKey<FormState>();

  TextEditingController _membernamecontroller = new TextEditingController();
  TextEditingController _memberPassordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) {
        return adminSideBloc;
      },
      child: Form(
        key: adduserformkey,
        child: AlertDialog(
          content: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              new TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'this field is required';
                  }
                },
                keyboardType: TextInputType.name,
                controller: _membernamecontroller,
                decoration: InputDecoration(hintText: "Enter member name"),
              ),
              SizedBox(
                height: 10.0,
              ),
              new TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return 'this field is required';
                  } else if (val.length <= 8) {
                    return 'password must be 8 char at least';
                  }
                },
                keyboardType: TextInputType.name,
                controller: _memberPassordcontroller,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  width: _width * 0.5,
                  child: DropdownButton(
                    key: Key(typevalue ?? ''),
                    value: typevalue,
                    isExpanded: true,
                    hint: Text("Select type"),
                    items: types,
                    onChanged: (val) {
                      setState(() {
                        typevalue = val;
                      });

                      print(typevalue);
                    },
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  width: _width * 0.5,
                  child: DropdownButton(
                    key: Key(gendervalue ?? ''),
                    value: gendervalue,
                    isExpanded: true,
                    hint: Text("Select type"),
                    items: genders,
                    onChanged: (val) {
                      setState(() {
                        gendervalue = val;
                      });

                      print(gendervalue);
                    },
                  )),
            ],
          ),
          scrollable: true,
          actions: [
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.red[900], fontStyle: FontStyle.italic),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontStyle: FontStyle.italic),
                ),
                onPressed: () async {
                  print(typevalue);
                  if (adduserformkey.currentState.validate()) {
                    adminSideBloc.add(AddnewMember(
                        id: widget.id,
                        users: Users(
                            rule: typevalue,
                            name: _membernamecontroller.text,
                            group: widget.group,
                            password: _memberPassordcontroller.text,
                            gender: gendervalue),
                        array: _membernamecontroller.text));
                    await Fluttertoast.showToast(
                        msg: "Added", gravity: ToastGravity.TOP);
                    Navigator.pop(context);
                  }
                }),
          ],
          title: Text("Add Member"),
        ),
      ),
    );
  }
}
