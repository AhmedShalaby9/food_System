import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/fetchdata/bloc.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/ui/admin/products/product_card.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';

import 'addPorduct_screen.dart';

Controller controller = new Controller();

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {
  FectchdataBloc bloc = new FectchdataBloc();
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  UniqueKey key;
  var selected = 0;
  var categoryname;
  @override
  void initState() {
    super.initState();

    adminSideBloc.add(FetchCategories(categorytype: categoryname));
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
      child: BlocBuilder(
        cubit: adminSideBloc,
        builder: (BuildContext context, state) {
          if (state is FetchCategoriessuccess) {
            return Scaffold(
                body: Column(
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
                            : Fluttertoast.showToast(msg: "Invalid Error");
                      },
                      child: ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, index) {
                          return Dismissible(
                              key: Key(state.products.toString()),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.red[900],
                                child: FlatButton.icon(
                                  label: Text(
                                    'delete',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  icon: Icon(Icons.delete, size: 28.0),
                                  onPressed: () {
                                    adminSideBloc.add(DeleteProduct(
                                        collection: 'products',
                                        id: state.products[index].id));
                                  },
                                ),
                              ),
                              onDismissed: (val) {
                                adminSideBloc.add(DeleteProduct(
                                    id: state.products[index].id,
                                    collection: 'products'));
                                adminSideBloc.add(FetchCategories(
                                    categorytype: categoryname));
                              },
                              child: ProductCard(
                                products: Products(
                                    name: state.products[index].name,
                                    qty: state.products[index].qty,
                                    url: state.products[index].url,
                                    price: state.products[index].price,
                                    id: state.products[index].id,
                                    type: state.products[index].type),
                              ));
                        },
                      ),
                    ))
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: Text("Add"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AddProduct();
                    }));
                  },
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
