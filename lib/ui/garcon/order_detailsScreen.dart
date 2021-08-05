import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/ui/garcon/oreders_Screen.dart';

class OrderDetails extends StatefulWidget {
  final Orders orders;

  OrderDetails({
    this.orders,
  });

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String btnstatus = "mark as deliverd";
  AdminSideBloc adminSideBloc = new AdminSideBloc();

  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) {
        return adminSideBloc;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: FlatButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              adminSideBloc.add(MarkOrderDeliverd(widget.orders.id));
              setState(() {
                btnstatus = '✔';
              });

              AwesomeDialog(
                headerAnimationLoop: true,
                useRootNavigator: true,
                onDissmissCallback: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return GarconOrdersScreen();
                  }), (Route<dynamic> route) => false);
                },
                autoHide: Duration(seconds: 3),
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Order Deliverd ',
                desc: widget.orders.order_name +
                    ' going to ' +
                    widget.orders.member_name +
                    " 🚶",
              )..show();
            },
            child: Text(btnstatus),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "order details",
            style: Theme.of(context).appBarTheme.textTheme.bodyText1,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: new Text(
                    widget.orders.member_name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Center(
                  child: new Text(
                    widget.orders.group,
                    //  style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(
                      'Status',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      widget.orders.order_status == 'pending'
                          ? 'Waiting ⏳'
                          : 'Deliverd ✔️',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new Text(widget.orders.datetime,
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Theme.of(context).primaryColor),
                      left: BorderSide(color: Theme.of(context).primaryColor),
                      right: BorderSide(color: Theme.of(context).primaryColor),
                      top: BorderSide(color: Theme.of(context).primaryColor),
                    )),
                    height: 150.0,
                    width: 150.0,
                    child: CachedNetworkImage(
                      imageUrl: widget.orders.url,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor),
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: new Text(
                    widget.orders.quantity.toString(),
                    //  style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Center(
                    child: new Text(widget.orders.order_name,
                        style: Theme.of(context).textTheme.bodyText1)),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        new Text("Comments : ",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                    Text(widget.orders.addtions == ''
                        ? 'no comments'
                        : widget.orders.addtions)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
