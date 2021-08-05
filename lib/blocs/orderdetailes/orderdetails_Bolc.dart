import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/orderdetailes/bloc.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:garson_app/controller/garcon_controller.dart';

Controller controller = new Controller();
Garconcontroller garconcontroller = new Garconcontroller();

class OrderDetaisBloc extends Bloc<OrderDetaisEvents, OrderDetaisStates> {
  OrderDetaisBloc(OrderDetaisStates initialState) : super(initialState);
  static OrderDetaisBloc get(BuildContext context) => BlocProvider.of(context);
  var qty = 1;
  @override
  Stream<OrderDetaisStates> mapEventToState(OrderDetaisEvents event) async* {
    if (event is IncreaseSugar) {
      var quantity = qty++;
      yield IncreaseSuccssed(quantity: quantity.toString());
    } else if (event is DicreaseSugar) {
      var quantity = qty != 0 ? qty-- : qty;
      yield DicreaseSuccssed(quantity: quantity.toString());
    }
    if (event is MakeOrder) {
      try {
        await controller.adddata(collection: 'orders', data: {
          'time': event.orders.time,
          'member_name': event.orders.member_name,
          'order_name': event.orders.order_name,
          'datetime': event.orders.datetime,
          'group': event.orders.group,
          'order_status': event.orders.order_status,
          'addtions': event.orders.addtions,
          'quantity': event.orders.quantity,
          'url': event.orders.url,
          'date': event.orders.date,
          'price': event.orders.price
        });
        String token = await garconcontroller.gettoken();
        await garconcontroller.notification(
            token: token,
            title: event.orders.member_name +
                " from " +
                event.orders.group +
                " has deliverd an order",
            body: event.orders.order_name);

        await controller.updateData(
            collection: 'products',
            id: event.id,
            data: {"quantity": event.qty});
        yield MakeOrderSuccess();
      } catch (e) {
        yield MakeOrderFailled(errormsg: e.toString());
      }
    }
  }
}
