import 'user_preferences.dart';
import 'package:get/get.dart';
import 'User.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User( '', '', '','','').obs;

  User get user => _currentUser.value;

  getUserInfo() async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value =  getUserInfoFromLocalStorage!;
  }
}
