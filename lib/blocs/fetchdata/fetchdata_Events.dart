import 'package:equatable/equatable.dart';
 
abstract class FetchdataEvents extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FetchProduct extends FetchdataEvents {
  final String productType;
  FetchProduct({this.productType});
}
