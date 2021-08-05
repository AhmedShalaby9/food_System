import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:image_picker/image_picker.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';

Controller controller = new Controller();

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  void initState() {
    adminSideBloc.add(FetchCategories());
    super.initState();
  }

  var value;
  AdminSideBloc adminSideBloc = new AdminSideBloc();
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  File _image;
  String imageUrl;
  final picker = ImagePicker();
  TextEditingController productnamecontroller = new TextEditingController();
  TextEditingController productquantitycontroller = new TextEditingController();
  TextEditingController productpricecontroller = new TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    //  var _height = MediaQuery.of(context).size.height;

    return BlocListener<AdminSideBloc, AdminSideStates>(
      cubit: adminSideBloc,
      listener: (BuildContext context, state) {
        if (state is DeleteProductSuccess) {
          print("delete succes");
        } else if (state is AddProductFailled) {
          return Scaffold.of(context).showSnackBar(_snackbar(state.errormsg));
        } else if (state is AddProductSuccess) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'done');
        } else if (state is LoadingWhenUploadProductSatate) {
          print('upload');
        } else if (state is ErrorState) {
          return Fluttertoast.showToast(msg: state.errormsg);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Product",
            style: Theme.of(context).appBarTheme.textTheme.bodyText1,
          ),
        ),
        body: BlocBuilder<AdminSideBloc, AdminSideStates>(
          cubit: adminSideBloc,
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: _width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),
                          color: Theme.of(context).primaryColor),
                      child: InkWell(
                        onTap: () async {
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);

                          setState(() {
                            if (pickedFile != null) {
                              _image = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                        child: Center(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: _image != null
                                  ? FileImage(_image)
                                  : AssetImage('assets/add.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: _width * 0.7,
                        child: BlocBuilder(
                          cubit: adminSideBloc,
                          builder: (BuildContext context, state) {
                            if (state is FetchCategoriessuccess) {
                              return DropdownButton(
                                value: value,
                                isExpanded: true,
                                hint: Text("Select type"),
                                items: state.categories.map((data) {
                                  return DropdownMenuItem(
                                    child: Text(data.name),
                                    value: data.name,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    value = val;
                                  });
                                },
                              );
                            } else {
                              return Text("loading");
                            }
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          controller: productnamecontroller,
                          keyboardType: TextInputType.name,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter name of product";
                            }
                          },
                          decoration:
                              InputDecoration(hintText: "Enter product name"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          controller: productquantitycontroller,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter quantity";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Enter product quantity"),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: _width * 0.8,
                        child: new TextFormField(
                          controller: productpricecontroller,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val.isEmpty) {
                              return "Please enter price";
                            }
                          },
                          decoration:
                              InputDecoration(hintText: "Enter product price"),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: _width * 0.5,
                      child: state is LoadingWhenUploadProductSatate
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : Builder(
                              builder: (BuildContext context) {
                                return FlatButton(
                                    color: Theme.of(context).primaryColor,
                                    child: Text("Add"),
                                    onPressed: () async {
                                      print("uploading");

                                      if (globalKey.currentState.validate()) {
                                        if (_image == null) {
                                          print('imgae=null');
                                          Scaffold.of(context).showSnackBar(
                                              _snackbar(
                                                  'you must select image from your gallery'));
                                        } else if (value == null) {
                                          Fluttertoast.showToast(
                                              gravity: ToastGravity.TOP,
                                              msg: 'select product type');
                                          print('value=null');
                                        } else {
                                          adminSideBloc
                                              .add(AddProductToFireStore(
                                            imagepath: _image,
                                            products: Products(
                                                type: value,
                                                price: productpricecontroller
                                                    .text
                                                    .trim(),
                                                qty: int.parse(
                                                    productquantitycontroller
                                                        .text
                                                        .trim()),
                                                name: productnamecontroller.text
                                                    .trim()
                                                    .toLowerCase()),
                                          ));

                                          print('done');
                                        }
                                      }
                                    });
                              },
                            ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _snackbar(String title) {
    return SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(title),
    );
  }
}
