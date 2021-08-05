import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/fetchdata/bloc.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/ui/user/menu/item_card.dart';
import 'package:garson_app/ui/user/products/product_details.dart';
import 'package:garson_app/ui/user/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

Controller controller = new Controller();

class HomeScreen extends StatefulWidget {
  var data;
  HomeScreen({this.data});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  FectchdataBloc bloc = new FectchdataBloc();
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  UniqueKey key;
  var selected = 0;
  var categoryname;
  var id;
  getid() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return id = pref.getString('id');
  }

  @override
  void initState() {
    adminSideBloc.add(FetchCategories(categorytype: categoryname));
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    print(categoryname);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return bloc;
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return adminSideBloc;
          },
        )
      ],
      child: (Scaffold(
        drawer: DraWer(
          id: id,
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          actions: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
            )
          ],
          title: Text(
            "Menu",
            style: Theme.of(context).appBarTheme.textTheme.bodyText1,
          ),
        ),
        body: BlocBuilder(
            cubit: adminSideBloc,
            builder: (BuildContext context, state) {
              if (state is FetchCategoriessuccess) {
                return Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        height: 60.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selected = index;
                                  categoryname =
                                      state.categories[selected].name;
                                  adminSideBloc.add(FetchCategories(
                                      categorytype: categoryname));
                                  print(selected.toString());
                                  print(categoryname);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selected == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  width: state.categories.length <= 2
                                      ? _width * 0.5
                                      : _width * 0.3,
                                  child: Center(
                                      child: Text(
                                    state.categories[index].name,
                                    style: TextStyle(
                                        color: selected == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            );
                          },
                        )),
                    new Expanded(
                        child: RefreshIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).buttonColor,
                      onRefresh: () async {
                        state is FetchCategoriessuccess
                            ? adminSideBloc.add(
                                FetchCategories(categorytype: categoryname))
                            : Fluttertoast.showToast(msg: "Invaild Error");
                      },
                      child: ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ProductDetails(
                                    userdata: widget.data,
                                    products: Products(
                                        qty: state.products[index].qty,
                                        id: state.products[index].id,
                                        name: state.products[index].name,
                                        price: state.products[index].price,
                                        type: categoryname,
                                        url: state.products[index].url));
                              }));
                            },
                            child: ItemCard(
                              name: state.products[index].name,
                              url: state.products[index].url,
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }),
      )),
    );
  }
}
