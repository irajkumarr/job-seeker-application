import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app.dart';
import 'package:frontend/core/services/app_state.dart';
import 'package:frontend/firebase_options.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppStateService.initialize();
  // Lock the app in portrait mode
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  runApp(const App());
}
