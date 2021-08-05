import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/models/orders/orders.dart';

import 'orders_card.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();

    adminSideBloc.add(FetchOrders(orderType: 'Deliverd'));
  }

  AdminSideBloc adminSideBloc = new AdminSideBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return adminSideBloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
          centerTitle: true,
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
            } else if (state is FetchOrdersSuccess) {
              return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (BuildContext context, index) {
                    return ordersCard(
                        orders: Orders(
                            url: state.orders[index].url,
                            datetime: state.orders[index].datetime,
                            group: state.orders[index].group,
                            member_name: state.orders[index].member_name,
                            order_name: state.orders[index].order_name));
                  });
            } else {
              return Text("Invalid to Fetch orders");
            }
          },
        ),
      ),
    );
  }
}
