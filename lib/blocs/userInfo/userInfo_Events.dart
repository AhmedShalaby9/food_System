import 'package:garson_app/models/users/users.dart';

class UserInfoEvents {}

class FetchUserInfo extends UserInfoEvents {
  final String id;
  FetchUserInfo({this.id});
}

class UpdateProfile extends UserInfoEvents {
  final Users user;
  final String id;
  var imagepath;
  UpdateProfile({this.user, this.id, this.imagepath});
}

class FetchUserOrders extends UserInfoEvents {}
