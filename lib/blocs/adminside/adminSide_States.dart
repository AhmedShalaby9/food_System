import 'package:garson_app/models/categories/categories.dart';
import 'package:garson_app/models/groups/groups.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/models/users/users.dart';

abstract class AdminSideStates {}

class InitialStates extends AdminSideStates {}

class WaitingForEditSatates extends AdminSideStates {}

class LoadingProductsState extends AdminSideStates {}

class DeleteProductSuccess extends AdminSideStates {}

class DeleteUsersSuccess extends AdminSideStates {}

class DeleteGroupSuccess extends AdminSideStates {}

class MarkOrderDeliverdsuccess extends AdminSideStates {}

class UploadImageProductSuccess extends AdminSideStates {
  UploadImageProductSuccess();
}

class AddProductSuccess extends AdminSideStates {}

class FetchCategoriesOnlySuccess extends AdminSideStates {
  final List<Categories> categories;
  FetchCategoriesOnlySuccess({this.categories});
}

class Uploadsuccess extends AdminSideStates {}

class AddProductFailled extends AdminSideStates {
  var errormsg;
  AddProductFailled({this.errormsg});
}

class DeleteProductFailled extends AdminSideStates {
  final String errormsg;
  DeleteProductFailled({this.errormsg});
}

class FethGroupsSuccess extends AdminSideStates {
  final List<Groups> groups;
  FethGroupsSuccess({this.groups});
}

class FethFailled extends AdminSideStates {
  final String erroremsg;
  FethFailled({this.erroremsg});
}

class EditProductSuccess extends AdminSideStates {
  var msg;
  EditProductSuccess({this.msg});
}

class FetchOrdersSuccess extends AdminSideStates {
  final List<Orders> orders;
  FetchOrdersSuccess({this.orders});
}

class FetchordersUsingFilterSuccess extends AdminSideStates {
  final List<Orders> orders;
  FetchordersUsingFilterSuccess({this.orders});
}

class ErrorState extends AdminSideStates {
  var errormsg;
  ErrorState({this.errormsg});
}

class FetchUsersSuccess extends AdminSideStates {
  final List<Users> users;
  FetchUsersSuccess({this.users});
}

class FetchCategoriessuccess extends AdminSideStates {
  final List<Categories> categories;
  final List<Products> products;
  FetchCategoriessuccess({this.categories, this.products});
}

class SubmittedOrderSuccess extends AdminSideStates {}

class DeleteCategoriesSuccess extends AdminSideStates {}

class AddCategoriesSuccess extends AdminSideStates {}

class LoadingWhenUploadProductSatate extends AdminSideStates {}

class FetchProdcutsSuccess extends AdminSideStates {
  final List<Products> products;
  FetchProdcutsSuccess({this.products});
}
