import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'itemorder_card.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    adminSideBloc.add(FetchOrders(orderType: 'pending'));
  }

  AdminSideBloc adminSideBloc = new AdminSideBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
        cubit: adminSideBloc,
        listener: (BuildContext context, state) {
          if (state is FetchOrdersSuccess) {
            print('done');
          }
        },
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            if (adminSideBloc.state is FetchOrdersSuccess) {
              adminSideBloc.add(FetchOrders(orderType: 'pending'));
            }
          },
          child: Scaffold(
              body: BlocBuilder<AdminSideBloc, AdminSideStates>(
            cubit: adminSideBloc,
            builder: (BuildContext context, state) {
              if (state is FetchOrdersSuccess) {
                print(state.orders.length.toString());
                return state.orders.length == 0
                    ? Center(
                        child: Text(
                          "No orders now !",
                          style: TextStyle(
                              color: Theme.of(context).buttonColor,
                              fontSize: 20.0),
                        ),
                      )
                    : ListView.builder(
                        itemCount: state.orders?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ItemOderCard(
                            orders: state.orders[index],
                          );
                        },
                      );
              } else if (state is InitialStates) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              } else if (state is FethFailled) {
                return Center(child: Text('error'));
              } else {
                return Text('error');
              }
            },
          )),
        ));
  }
}
