import 'package:bloc/bloc.dart';
import 'package:garson_app/blocs/fetchdata/bloc.dart';
import 'package:garson_app/controller/admin_controller.dart';
import 'package:garson_app/models/products/products.dart';

AdminController adminController = new AdminController();

class FectchdataBloc extends Bloc<FetchdataEvents, FetchdataStates> {
  FectchdataBloc() : super(InitialState());

  @override
  Stream<FetchdataStates> mapEventToState(FetchdataEvents event) async* {
    if (event is FetchProduct) {
      print("done");
      List<Products> products = await adminController.getproducts();
      yield FetchProductSuccesss(products: products);
    }
  }
}
