import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do/screen/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/todo.dart';


Future<void> main() async {
  Hive
    ..initFlutter()
    ..init((await getApplicationSupportDirectory()).path)
    ..registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>('todos');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}