import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', '');
  final box = GetStorage();
  bool get isLanguageSelected => box.read('isLanguageSelected') ?? false;

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    box.write("languageCode", locale.languageCode);

    box.write('isLanguageSelected', true);
  }

  void loadSavedLanguage() async {
    final languageCode = box.read('languageCode') ?? 'en';

    _locale = Locale(languageCode, '');
    notifyListeners();
  }
}