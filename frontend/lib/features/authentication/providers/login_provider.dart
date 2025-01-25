import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool rememberMe = false;

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }
}


  ///save data if remember me is selected
      // if (rememberMe.value) {
      //   localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
      //   localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      // }