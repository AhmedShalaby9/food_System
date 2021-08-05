import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';

import 'package:garson_app/ui/user/userOrders/detailes_Card.dart';

import 'components.dart';
import 'user_orders_card.dart';

class UserOrders extends StatefulWidget {
  final String name;
  UserOrders({this.name});
  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders>
    with SingleTickerProviderStateMixin {
  var selectedMonth;

  @override
  void initState() {
    super.initState();
    adminSideBloc.add(FetchOrders(
        orderType: 'Deliverd', curentUser: true, username: widget.name));
  }

  AdminSideBloc adminSideBloc = new AdminSideBloc();
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    print(widget.name);
    return BlocProvider(
      create: (BuildContext context) {
        return adminSideBloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Orders",
            style: Theme.of(context).appBarTheme.textTheme.bodyText1,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            new SizedBox(
              height: _height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: new Text(
                "Filtter Your Orders 🔍",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            PhysicalModel(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
              elevation: 8,
              shadowColor: Theme.of(context).buttonColor,
              child: SizedBox(
                height: 50.0,
                width: _width * 0.8,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: new DropdownButton(
                      onTap: () {},
                      iconSize: 30.0,
                      iconDisabledColor: Theme.of(context).primaryColor,
                      iconEnabledColor: Theme.of(context).buttonColor,
                      underline: SizedBox(),
                      hint: Text(
                        "Select month",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      isExpanded: true,
                      items: monthes,
                      value: selectedMonth,
                      onChanged: (val) {
                        setState(() {
                          selectedMonth = val;
                          adminSideBloc.add(FetchOrdersUsingFilter(
                              date: val, username: widget.name));
                        });
                      }),
                ),
              ),
            ),
            new SizedBox(
              height: _height * 0.03,
            ),
            Stack(
              children: [
                Divider(
                  color: Theme.of(context).buttonColor,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                      // height: 20.0,
                      width: _width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Theme.of(context).buttonColor),
                      child: Center(
                        child: Text(
                          selectedMonth == null ? 'All orders' : selectedMonth,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                )
              ],
            ),
            Expanded(
              child: new BlocBuilder(
                  cubit: adminSideBloc,
                  builder: (BuildContext context, state) {
                    if (state is InitialStates) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).buttonColor,
                        ),
                      );
                    } else if (state is FetchOrdersSuccess) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.orders.length,
                                itemBuilder: (BuildContext context, index) {
                                  return userOrderCard(
                                      context: context,
                                      orders: state.orders[index],
                                      width: _width * 0.55);
                                }),
                          ),
                          detailesCard(
                            context: context,
                            length: state.orders.length.toString(),
                          )
                        ],
                      );
                    } else if (state is FetchordersUsingFilterSuccess) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.orders.length,
                                itemBuilder: (BuildContext context, index) {
                                  return userOrderCard(
                                      context: context,
                                      orders: state.orders[index],
                                      width: _width * 0.55);
                                }),
                          ),
                          detailesCard(
                            context: context,
                            length: state.orders.length.toString(),
                          )
                        ],
                      );
                    } else {
                      return Text("Check");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
