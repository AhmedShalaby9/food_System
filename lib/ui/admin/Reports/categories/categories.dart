import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/models/categories/categories.dart';

import 'categories_Card.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  GlobalKey<FormState> addCategoryKey = GlobalKey<FormState>();
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    adminSideBloc.add(FetchCategoriesOnly());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return adminSideBloc;
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
                          key: addCategoryKey,
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
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                      hintText: "Enter Category name"),
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
                                  if (addCategoryKey.currentState.validate()) {
                                    adminSideBloc.add(AddCategories(
                                        categories: Categories(
                                            name: textEditingController.text)));
                                    await Fluttertoast.showToast(
                                        msg: "category Added",
                                        gravity: ToastGravity.TOP);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ],
                            title: Text("Add Category"),
                          ),
                        );
                      },
                      context: context)
                  .then((val) {
                adminSideBloc.add(FetchCategoriesOnly());
              });
            }),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     adminSideBloc.add(AddCategories(
        //       categories: Categories(
        //         name:
        //       )
        //     ));
        //   },
        // ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Categories",
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
            if (state is FetchCategoriesOnlySuccess) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (BuildContext context, index) {
                  return categoriescard(
                      ontab: () {
                        adminSideBloc.add(
                            DeleteCategories(id: state.categories[index].id));
                        adminSideBloc.add(FetchCategoriesOnly());
                      },
                      categories: Categories(
                        name: state.categories[index].name,
                      ));
                },
              );
            } else {
              return Text("error");
            }
          },
        ),
      ),
    );
  }
}
