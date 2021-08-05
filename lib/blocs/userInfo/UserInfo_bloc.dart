import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garson_app/blocs/userInfo/bloc.dart';
import 'package:garson_app/controller/user_controller.dart';
import 'package:garson_app/controller/api_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Controller _controller = new Controller();
UserController userController = new UserController();

class UserInfoBloc extends Bloc<UserInfoEvents, UserInfoStates> {
  UserInfoBloc(UserInfoStates initialState) : super(initialState);

  @override
  Stream<UserInfoStates> mapEventToState(UserInfoEvents event) async* {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('id'));
    if (event is FetchUserInfo) {
      try {
        var result = await userController.getUserdata(id: pref.getString('id'));
        yield FetchUserInfoSuccess(user: result);
      } catch (e) {
        yield OnExption(errormsg: e.toString());
      }
    } else if (event is UpdateProfile) {
      try {
        yield LoadingState();
        var url;
        event.imagepath == null
            ? url = 'null'
            : url = await _controller.uploadimage(imagpath: event.imagepath);
        await _controller.updateData(collection: 'users', id: event.id, data: {
          'name': event.user.name,
          'password': event.user.password,
          'imageurl': url
        });
        yield UpdateProfileSuccess();
      } catch (e) {
        yield OnExption(errormsg: e.toString());
      }
    }
  }
}
