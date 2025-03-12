import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/LoginPage.dart';
import 'Pages/RegisterPage.dart';

int? isFirstTime;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstTime = prefs.getInt('onBoard');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstTime != 0 ? const Register() : const Login(),
    );
  }
}
