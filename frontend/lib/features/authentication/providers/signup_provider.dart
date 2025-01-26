import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  bool termsAndConditions = true;

  void toggleTermsAndConditions() {
    termsAndConditions = !termsAndConditions;
    notifyListeners();
  }
}