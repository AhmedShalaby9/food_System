import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Edit extends StatefulWidget {
  final Products products;
  Edit(this.products);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  File _newimage;
  String newimageUrl;
  final picker = ImagePicker();
  GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();

  String newName, newPrice;
  int newQty;
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) {
        return adminSideBloc;
      },
      child: BlocConsumer(
        cubit: adminSideBloc,
        listener: (BuildContext context, state) {
          if (state is WaitingForEditSatates) {
            Fluttertoast.showToast(
                msg: "Waiting",
                gravity: ToastGravity.CENTER,
                backgroundColor: Theme.of(context).primaryColor);
          } else if (state is EditProductSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Edit",
                style: Theme.of(context).appBarTheme.textTheme.bodyText1,
              ),
            ),
            body: Form(
              key: _globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    new SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);

                              setState(() {
                                if (pickedFile != null) {
                                  _newimage = File(pickedFile.path);
                                } else {
                                  print('No image selected.');
                                }
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: _newimage == null
                                  ? CachedNetworkImage(
                                      height: 170,
                                      width: _width * 0.5,
                                      fit: BoxFit.cover,
                                      imageUrl: widget.products.url,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                            backgroundColor:
                                                Theme.of(context).primaryColor),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    )
                                  : Image.file(_newimage),
                            ),
                          ),
                          new IconButton(
                            onPressed: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);

                              setState(() {
                                if (pickedFile != null) {
                                  _newimage = File(pickedFile.path);
                                } else {
                                  print('No image selected.');
                                }
                              });
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 25.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          onSaved: (savedname) {
                            print(savedname);
                            return newName = savedname;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "enter product name";
                            }
                          },
                          initialValue: widget.products.name,
                          decoration: InputDecoration(
                              icon: Icon(Icons.edit), labelText: "name"),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          onSaved: (savedprice) {
                            print(savedprice);
                            return newPrice = savedprice;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "enter product price";
                            }
                          },
                          // controller: pricecontroller,
                          initialValue: widget.products.price,
                          decoration: InputDecoration(
                              icon: Icon(Icons.edit), labelText: "Price"),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          onSaved: (savedquantity) {
                            var qtystring = int.parse(savedquantity);
                            print(savedquantity);
                            newQty = qtystring;
                          },
                          validator: (val) {
                            if (val.isEmpty) {
                              return "enter product Quantity";
                            }
                          },
                          initialValue: widget.products.qty.toString(),
                          decoration: InputDecoration(
                              icon: Icon(Icons.edit), labelText: "Quantity"),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: _width * 0.5,
                      child: state is WaitingForEditSatates
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Theme.of(context).primaryColor,
                            ))
                          : Builder(
                              builder: (BuildContext context) {
                                return FlatButton(
                                    color: Theme.of(context).buttonColor,
                                    child: Text("Submit"),
                                    onPressed: () async {
                                      if (_globalKey.currentState.validate()) {
                                        _globalKey.currentState.save();
                                        adminSideBloc.add(EditProduct(
                                            products: Products(
                                                id: widget.products.id,
                                                name: newName,
                                                price: newPrice,
                                                qty: newQty),
                                            imagePath: _newimage));
                                      }
                                      print("Updating");
                                    });
                              },
                            ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: _width * 0.5,
                      child: Builder(
                        builder: (BuildContext context) {
                          return FlatButton(
                              color: Theme.of(context).primaryColor,
                              child: Text("Cancel"),
                              onPressed: () async {
                                Navigator.pop(context);
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
