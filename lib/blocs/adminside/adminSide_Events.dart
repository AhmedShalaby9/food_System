import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:garson_app/models/categories/categories.dart';
import 'package:garson_app/models/groups/groups.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/models/users/users.dart';

abstract class AdminSideEvents {}

class DeleteProduct extends AdminSideEvents {
  final String collection;
  final String id;
  DeleteProduct({this.collection, this.id});
}

class AddProductToFireStore extends AdminSideEvents {
  final String collection;
  final Products products;
  var imagepath;
  AddProductToFireStore({this.collection, this.products, this.imagepath});
}

class FethGroups extends AdminSideEvents {
  final List<Groups> groups;
  FethGroups({this.groups});
}

class FetchCategories extends AdminSideEvents {
  final List<Categories> categories;
  final String categorytype;
  FetchCategories({this.categories, this.categorytype});
}

class FetchCategoriesOnly extends AdminSideEvents {}

class FetchProducts extends AdminSideEvents {
  final List<Products> products;

  FetchProducts({this.products});
}

class EditProduct extends AdminSideEvents {
  final Products products;
  final File imagePath;
  EditProduct({this.products, this.imagePath});
}

class DeleteUser extends AdminSideEvents {
  final String id;

  DeleteUser({
    @required this.id,
  });
}

class DeleteGroup extends AdminSideEvents {
  final String id;

  DeleteGroup({
    @required this.id,
  });
}

class DeleteMember extends AdminSideEvents {
  final String id;
  final String username;
  var array;
  DeleteMember({@required this.id, this.username, this.array});
}

class AdduserToGroup extends AdminSideEvents {
  final String id;
  final String username;
  var array;
  AdduserToGroup({@required this.id, this.username, this.array});
}

class FetchOrders extends AdminSideEvents {
  final String orderType;
  final String username;
  final bool curentUser;
  FetchOrders({@required this.orderType, this.username, this.curentUser});
}

class SaveToken extends AdminSideEvents {}

class FetchOrdersUsingFilter extends AdminSideEvents {
  final String date;
  final String username;
  FetchOrdersUsingFilter({@required this.date, this.username});
}

class FetchUsers extends AdminSideEvents {}

class AddCategories extends AdminSideEvents {
  final Categories categories;
  AddCategories({this.categories});
}

class DeleteCategories extends AdminSideEvents {
  final String id;
  DeleteCategories({this.id});
}

class MarkOrderDeliverd extends AdminSideEvents {
  final String id;
  MarkOrderDeliverd(this.id);
}

class AddnewGroup extends AdminSideEvents {
  final Groups groups;
  AddnewGroup({this.groups});
}

class AddnewMember extends AdminSideEvents {
  final String id;

  final Users users;
  var array;

  AddnewMember({this.id, this.array, this.users});
}
