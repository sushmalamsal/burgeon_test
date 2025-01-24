import 'package:burgeon/views/get_method.dart';
// import 'package:burgeon/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExampleView()
        // home: LoginView()
        );
  }
}
