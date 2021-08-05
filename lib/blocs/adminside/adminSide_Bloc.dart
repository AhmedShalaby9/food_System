import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:garson_app/blocs/adminside/bloc.dart';
import 'package:garson_app/controller/admin_controller.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/controller/product_controller.dart';
import 'package:garson_app/controller/user_controller.dart';
import 'package:garson_app/models/categories/categories.dart';
import 'package:garson_app/models/groups/groups.dart';
import 'package:garson_app/models/orders/orders.dart';
import 'package:garson_app/models/products/products.dart';
import 'package:garson_app/models/users/users.dart';

Controller controller = new Controller();
UserController userController = new UserController();
ProductController productController = new ProductController();
AdminController adminController = new AdminController();

class AdminSideBloc extends Bloc<AdminSideEvents, AdminSideStates> {
  AdminSideBloc() : super(InitialStates());

  @override
  Stream<AdminSideStates> mapEventToState(AdminSideEvents event) async* {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    if (event is EditProduct) {
      try {
        yield WaitingForEditSatates();
        var url;
        event.imagePath != null
            ? url = await controller.uploadimage(imagpath: event.imagePath)
            : url = event.products.url;
        await controller.updateData(
            collection: 'products',
            data: event.imagePath != null
                ? {
                    'url': url,
                    'name': event.products.name,
                    'price': event.products.price,
                    'quantity': event.products.qty
                  }
                : {
                    'name': event.products.name,
                    'price': event.products.price,
                    'quantity': event.products.qty
                  },
            id: event.products.id);
        yield EditProductSuccess();
      } catch (e) {
        yield ErrorState(errormsg: e.toString());
      }
    } else if (event is FetchCategories) {
      // yield LoadingProductsState();
      try {
        List<Categories> categories = await adminController.getcategories();

        var products = await productController.getproductsUsingtype(
          producttype: event.categorytype == null
              ? categories.first.name
              : event.categorytype,
        );
        yield FetchCategoriessuccess(
            categories: categories, products: products);
      } catch (e) {
        yield ErrorState(errormsg: e.toString());
      }
    } else if (event is FetchCategoriesOnly) {
      try {
        List<Categories> categories = await adminController.getcategories();
        yield FetchCategoriesOnlySuccess(categories: categories);
      } catch (e) {
        yield FethFailled(erroremsg: e.toString());
      }
    } else if (event is SaveToken) {
      var devicetoken = await firebaseMessaging.getToken();
      await controller
          .adddata(collection: 'devicetoken', data: {"token": devicetoken});
    } else if (event is AddCategories) {
      try {
        await controller.adddata(
            collection: 'categories', data: {'name': event.categories.name});
      } catch (e) {
        ErrorState(errormsg: e.toString());
      }
    } else if (event is FetchUsers) {
      try {
        List<Users> users = await adminController.getUsers();
        yield FetchUsersSuccess(users: users);
      } catch (e) {
        yield FethFailled(erroremsg: e.toString());
      }
    } else if (event is FetchProducts) {
      try {
        List<Products> products = await adminController.getproducts();
        yield FetchProdcutsSuccess(products: products);
      } catch (e) {
        yield FethFailled(erroremsg: e.toString());
      }
    } else if (event is MarkOrderDeliverd) {
      try {
        await controller.updateData(
            collection: 'orders',
            data: {"order_status": "Deliverd"},
            id: event.id);
        yield SubmittedOrderSuccess();
      } catch (e) {
        ErrorState(errormsg: e.toString());
      }
    } else if (event is FethGroups) {
      try {
        print("done");
        List<Groups> groups =
            await controller.getdataList(collection: 'groups');
        yield FethGroupsSuccess(groups: groups);
      } catch (e) {
        yield FethFailled(erroremsg: e.message.toString());
      }
    } else if (event is AddnewMember) {
      await controller.adddata(collection: 'users', data: {
        "name": event.users.name,
        "group": event.users.group,
        "password": event.users.password,
        "rule": event.users.rule,
        'imageurl': 'null',
        'gender': event.users.gender
      });
      await controller.addmember(
          id: event.id, array: event.array, fieldname: 'users');
    } else if (event is AddnewGroup) {
      await controller.adddata(
          collection: 'groups',
          data: {'name': event.groups.name, 'users': event.groups.users});
    } else if (event is FetchOrders) {
      try {
        List<Orders> orders = await controller.getorders(
            ordertype: event.orderType,
            cuurentuser: event.curentUser,
            username: event.username);
        yield FetchOrdersSuccess(orders: orders);
      } catch (e) {
        yield FethFailled(erroremsg: e.message.toString());
      }
    } else if (event is FetchOrdersUsingFilter) {
      try {
        yield InitialStates();
        List<Orders> orders = await userController.getordersUsingFfilter(
            date: event.date, username: event.username);
        yield FetchordersUsingFilterSuccess(orders: orders);
      } catch (e) {
        yield FethFailled(erroremsg: e.message.toString());
      }
    } else if (event is DeleteMember) {
      try {
        await controller.deletemember(
            id: event.id, username: event.username, array: event.array);
      } catch (e) {
        yield FethFailled(erroremsg: e.message.toString());
      }
    } else if (event is DeleteUser) {
      await controller.deletedata(collection: 'users', id: event.id);
      yield DeleteUsersSuccess();
    } else if (event is DeleteGroup) {
      await controller.deletedata(collection: 'groups', id: event.id);
      yield DeleteGroupSuccess();
    } else if (event is DeleteCategories) {
      try {
        await controller.deletedata(collection: 'categories', id: event.id);
      } catch (e) {
        yield ErrorState(errormsg: e.toString());
      }
    } else if (event is DeleteProduct) {
      try {
        await controller.deletedata(collection: event.collection, id: event.id);
        yield DeleteProductSuccess();
      } catch (e) {
        yield DeleteProductFailled(errormsg: e.message.toString());
      }
    } else if (event is AddProductToFireStore) {
      try {
        yield LoadingWhenUploadProductSatate();
        var url = await controller.uploadimage(imagpath: event.imagepath);
        await controller.adddata(collection: 'products', data: {
          "type": event.products.type,
          'price': event.products.price,
          "name": event.products.name,
          "url": url,
          "quantity": event.products.qty
        });

        yield AddProductSuccess();
      } catch (e) {
        yield AddProductFailled(errormsg: e.message.toString());
      }
    }
  }
}
