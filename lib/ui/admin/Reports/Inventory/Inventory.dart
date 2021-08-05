import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/models/products/products.dart';

import 'invntory_card.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  @override
  void initState() {
    adminSideBloc.add(FetchProducts());
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
            "Inventory",
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
            if (state is FetchProdcutsSuccess) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, index) {
                  return inventoryCard(
                      products: Products(
                          name: state.products[index].name,
                          qty: state.products[index].qty));
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
