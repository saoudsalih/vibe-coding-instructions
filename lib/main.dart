import 'package:flutter/material.dart';
import 'package:vibe_coding_test/app/app.dart';
import 'package:vibe_coding_test/app/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}
