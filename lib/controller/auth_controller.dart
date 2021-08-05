import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  login({var username, password, data}) async {
    // login methid
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var result = await firestore
          .collection('users')
          // check if user name already exists...
          .where('name', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();
      print("result : ${result.docs.first.data()}");
      // check user type to load login poccess......
      var isadmin = result.docs.first.data().values.contains('admin');
      var isgarcon = result.docs.first.data().values.contains('garcon');
      var isuser = result.docs.first.data().values.contains('user');
      var groupname = result.docs.first.data()['group'];
      var id = result.docs.first.id;
      print(groupname);
      print("is user ? : $isuser".toString());
      print("is admin ? : $isadmin".toString());
      print("is garcon ? : $isgarcon".toString());
      print("id" + id.toString());
      // set user type in shared prefreance.....
      pref.setBool('isadmin', isadmin);
      pref.setBool('isgarcon', isgarcon);
      pref.setBool('isuser', isuser);
      pref.setString('id', id);
      //  return list of items [3] ,
      //1- bool value to know user type ,
      //2-  string value "groupname",
      //3- string value " user id"
      return [isadmin, isuser, isgarcon, groupname, id];
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
