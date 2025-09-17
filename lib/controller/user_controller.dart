import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var isLoggedIn = false.obs;
  var name = "".obs;
  var email = "".obs;
  var phone = "".obs;

  void login(String userName, String userEmail, String userPhone) async {
    name.value = userName;
    email.value = userEmail;
    phone.value = userPhone;
    isLoggedIn.value = true;

    // Save session
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("name", userName);
    await prefs.setString("email", userEmail);
    await prefs.setString("phone", userPhone);
  }

  void logout() async {
    name.value = "";
    email.value = "";
    phone.value = "";
    isLoggedIn.value = false;

    // Clear session
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool("isLoggedIn");
    if (loggedIn == true) {
      name.value = prefs.getString("name") ?? "";
      email.value = prefs.getString("email") ?? "";
      phone.value = prefs.getString("phone") ?? "";
      isLoggedIn.value = true;
    }
  }
}
