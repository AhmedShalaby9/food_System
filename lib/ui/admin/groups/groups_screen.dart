import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/models/groups/groups.dart';
import 'package:garson_app/ui/admin/groups/add_user_dialog.dart';
import 'gruopItem_card.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  var typevalue;
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  GlobalKey<FormState> addgroupformkey = new GlobalKey<FormState>();
  GlobalKey<FormState> adduserformkey = new GlobalKey<FormState>();

  TextEditingController _groupnamecontroller = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    adminSideBloc.add(FethGroups());
  }

  @override
  Widget build(BuildContext context) {
    //  var _width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) {
        return AdminSideBloc();
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
              tooltip: 'you can add new group',
              child: Text('Add'),
              onPressed: () {
                showDialog(
                        useSafeArea: true,
                        builder: (BuildContext context) {
                          return Form(
                            key: addgroupformkey,
                            child: AlertDialog(
                              content: Column(
                                children: [
                                  new TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'this field is required';
                                      }
                                    },
                                    keyboardType: TextInputType.name,
                                    controller: _groupnamecontroller,
                                    decoration: InputDecoration(
                                        hintText: "Enter group name"),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                              scrollable: true,
                              actions: [
                                FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.red[900],
                                        fontStyle: FontStyle.italic),
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
                                    if (addgroupformkey.currentState
                                        .validate()) {
                                      adminSideBloc.add(AddnewGroup(
                                          groups: Groups(
                                              users: [],
                                              name:
                                                  _groupnamecontroller.text)));
                                      await Fluttertoast.showToast(
                                          msg: "Group Added",
                                          gravity: ToastGravity.TOP);
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ],
                              title: Text("Add group"),
                            ),
                          );
                        },
                        context: context)
                    .then((val) {
                  adminSideBloc.add(FethGroups());
                });
              }),
          body: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              if (adminSideBloc.state is FethGroupsSuccess) {
                adminSideBloc.add(FethGroups());
              }
            },
            child: BlocBuilder<AdminSideBloc, AdminSideStates>(
              cubit: adminSideBloc,
              // ignore: missing_return
              builder: (BuildContext context, state) {
                if (state is InitialStates) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (state is FethGroupsSuccess) {
                  return ListView.builder(
                    itemCount: state.groups.length,
                    itemBuilder: (BuildContext context, index) {
                      return GroupItemCard(
                        list: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.groups[index].users.length,
                              itemBuilder: (BuildContext context, i) {
                                return ListTile(
                                  trailing: IconButton(
                                      tooltip: 'delete member',
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                      onPressed: () async {
                                        adminSideBloc.add(DeleteMember(
                                            id: state.groups[index].id,
                                            array: state.groups[index].users[i]
                                                .toString(),
                                            username: 'users'));
                                        adminSideBloc.add(FethGroups());
                                        await Fluttertoast.showToast(
                                            msg: 'member deleted',
                                            gravity: ToastGravity.TOP);
                                      },
                                      color: Colors.red[900]),
                                  title: Text(
                                    state.groups[index].users[i],
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                );
                              },
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    useSafeArea: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddUserDialog(
                                        group: state.groups[index].name,
                                        id: state.groups[index].id,
                                      );
                                    }).then((val) {
                                  adminSideBloc.add(FethGroups());
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Add new Member ➡️',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        name: state.groups[index].name,
                        teamnum: state.groups[index].users.length.toString(),
                      );
                    },
                  );
                } else if (state is FethFailled) {
                  Fluttertoast.showToast(msg: state.erroremsg);
                } else {
                  return Text("error");
                }
              },
            ),
          )),
    );
  }
}
