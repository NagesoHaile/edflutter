import 'package:edir/core/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _user = User(
    username: '',
    firstName: '',
    middleName: '',
    lastName: '',
    password: '',
  ).obs;
  RxString username = ''.obs;

  User get user => _user.value;

  void setUser({required User user}) {
    _user.value = user;
  }

  void setUsername(String newUsername) {
    username.value = newUsername;
  }

  String getUsername() {
    return username.value;
  }
}
