import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/core_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) async => runApp(const CoreAppBlocWrapper()));
}
