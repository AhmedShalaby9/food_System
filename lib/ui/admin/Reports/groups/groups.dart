import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/models/groups/groups.dart';
import 'package:garson_app/ui/admin/Reports/groups/groupsCard.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  GlobalKey<FormState> addCategoryKey = GlobalKey<FormState>();
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    adminSideBloc.add(FethGroups());
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
            if (state is FethGroupsSuccess) {
              return ListView.builder(
                itemCount: state.groups.length,
                itemBuilder: (BuildContext context, index) {
                  return groupcard(
                      onpress: () {
                        adminSideBloc
                            .add(DeleteGroup(id: state.groups[index].id));
                        adminSideBloc.add(FethGroups());
                      },
                      memberNum: state.groups[index].users.length.toString(),
                      context: context,
                      groups: Groups(
                        id: state.groups[index].id,
                        name: state.groups[index].name,
                      ));
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).buttonColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
