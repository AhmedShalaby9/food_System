import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/ui/admin/Reports/users/Users_card.dart';
import 'package:garson_app/models/users/users.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  @override
  void initState() {
    adminSideBloc.add(FetchUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return adminSideBloc;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Users",
            style: Theme.of(context).appBarTheme.textTheme.bodyText1,
          ),
        ),
        body: BlocBuilder(
          cubit: adminSideBloc,
          builder: (BuildContext context, state) {
            if (state is InitialStates) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).buttonColor,
                ),
              );
            }
            if (state is FetchUsersSuccess) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (BuildContext context, index) {
                  return userCard(
                      onpress: () {
                        adminSideBloc
                            .add(DeleteUser(id: state.users[index].id));
                        adminSideBloc.add(FetchUsers());
                      },
                      context: context,
                      users: Users(
                          gender: state.users[index].gender,
                          group: state.users[index].group,
                          imageUrl: state.users[index].imageUrl,
                          name: state.users[index].name));
                },
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ));
            }
          },
        ),
      ),
    );
  }
}
