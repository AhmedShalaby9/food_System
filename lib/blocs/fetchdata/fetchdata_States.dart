import 'package:equatable/equatable.dart';
import 'package:garson_app/models/products/products.dart';

abstract class FetchdataStates extends Equatable {
  @override
  List<Object> get props => null;
}

class InitialState extends FetchdataStates {}

class FetchProductSuccesss extends FetchdataStates {
  final List<Products> products;
  FetchProductSuccesss({this.products});
}

class FetchFailled extends FetchdataStates {}
