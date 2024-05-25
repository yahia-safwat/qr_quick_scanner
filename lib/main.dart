import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  // Init Flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  // Init Dependencies
  // di.init();

  // Init the BlocObserver
  // Bloc.observer = AppBlocObserver();

  // Init the application
  runApp(const MyApp());
}
