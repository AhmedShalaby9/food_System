import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/blocs/login/login_bloc.dart';
import 'package:garson_app/blocs/orderdetailes/bloc.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/ui/user/menu/menu_Screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Controller controller = new Controller();

class ProductDetails extends StatefulWidget {
  final Products products;

  var userdata;
  ProductDetails({@required this.products, this.userdata});
  @override
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  OrderDetaisBloc orderDetaisBloc = OrderDetaisBloc(IntialStates());
  TextEditingController textEditingController = new TextEditingController();
  // ignore: close_sinks
  LoginBloc loginBloc = LoginBloc();

  void initState() {
    print("name : " + widget.products.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) {
            return orderDetaisBloc;
          },
        ),
        BlocProvider(
          create: (BuildContext context) {
            return loginBloc;
          },
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.products.name,
              style: Theme.of(context).appBarTheme.textTheme.bodyText1,
            ),
          ),
          body: BlocConsumer(
            cubit: orderDetaisBloc,
            listener: (BuildContext context, state) {
              if (state is MakeOrderSuccess) {
                AwesomeDialog(
                    headerAnimationLoop: true,
                    useRootNavigator: true,
                    onDissmissCallback: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomeScreen();
                      }), (Route<dynamic> route) => false);
                    },
                    autoHide: Duration(seconds: 3),
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Order submited😊 ',
                    desc: '✔️')
                  ..show();
              } else if (state is MakeOrderFailled) {
                Fluttertoast.showToast(msg: state.errormsg);
              }
            },
            builder: (BuildContext context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.products.url,
                      placeholder: (context, url) => Center(
                          child: SpinKitThreeBounce(
                        size: 25.0,
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor),
                          );
                        },
                      )),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'quantity',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          backgroundColor: Theme.of(context).accentColor,
                          heroTag: '2',
                          child: Icon(
                            Icons.remove,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            return orderDetaisBloc.add(DicreaseSugar());
                          },
                        ),
                        Text(
                          OrderDetaisBloc.get(context).qty.toString(),
                          style: TextStyle(
                              color: widget.products.qty >=
                                      OrderDetaisBloc.get(context).qty
                                  ? Colors.black
                                  : Colors.red),
                        ),
                        FloatingActionButton(
                          heroTag: '1',
                          backgroundColor: Theme.of(context).buttonColor,
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).accentColor,
                          ),
                          onPressed: () {
                            return orderDetaisBloc.add(IncreaseSugar());
                          },
                        ),
                      ],
                    ),
                    widget.products.qty >= OrderDetaisBloc.get(context).qty
                        ? SizedBox(
                            height: 5.0,
                          )
                        : Column(
                            children: [
                              new SizedBox(
                                height: 25,
                              ),
                              Text(
                                " Sorry, This quantity is not avalible now !",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                    Divider(),
                    SizedBox(
                      height: 15.0,
                    ),
                    widget.products.qty <= 0
                        ? Text(
                            "This Product not avaliable now",
                            style: TextStyle(color: Colors.red),
                          )
                        : SizedBox(
                            height: 15.0,
                          ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.note),
                              hintText: 'You can write any comments here.'),
                        )),
                    widget.products.qty < OrderDetaisBloc.get(context).qty
                        ? SizedBox()
                        : Container(
                            width: _width * 0.6,
                            margin: EdgeInsets.all(50),
                            child: FlatButton(
                              onPressed: () async {
                                if (widget.products.qty > 0) {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  var username = pref.getString('username');
                                  var groupname = pref.getString('groupname');
                                  print(groupname);
                                  print(username);

                                  orderDetaisBloc.add(MakeOrder(
                                      id: widget.products.id,
                                      qty: widget.products.qty -
                                          orderDetaisBloc.qty,
                                      orders: Orders(
                                          time: DateFormat.jm()
                                              .format(DateTime.now()),
                                          date: DateFormat.MMMM()
                                              .format(DateTime.now()),
                                          price: widget.products.price,
                                          quantity:
                                              orderDetaisBloc.qty.toString(),
                                          datetime: DateFormat.yMd()
                                              .add_jm()
                                              .format(new DateTime.now()),
                                          group: groupname.toString(),
                                          addtions: textEditingController.text,
                                          member_name: username.toString(),
                                          order_name: widget.products.name,
                                          id: widget.products.id.toString(),
                                          url: widget.products.url,
                                          order_status: 'pending')));
                                } else {
                                  return Fluttertoast.showToast(
                                    gravity: ToastGravity.TOP,
                                    msg: "Not available now !",
                                  );
                                }
                              },
                              child: Text(
                                  widget.products.qty <= 0 ? "✖️" : "Confirm",
                                  style: TextStyle(fontSize: 16.0)),
                              color: widget.products.qty <= 0
                                  ? Colors.red
                                  : Theme.of(context).buttonColor,
                            ),
                          ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
