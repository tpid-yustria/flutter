import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF43B1B7),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFED408),
        ),
      ),
      home: CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  late SharedPreferences sharedPreferences;
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    sharedPreferences = await SharedPreferences.getInstance(); // membuat instance SharedPreferences
    var token = sharedPreferences.getString('token'); // mengambil token dari SharedPreferences
    if (token != null) { // cek jika token tidak null
      if (mounted) { // cek jika widget sudah di-mounting
        setState(() { // mengubah state isAuth menjadi true
          isAuth = true;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) { // perbandingan sederhana dengan isAuth yang sudah dikondisikan tadi diatas
      child = MainScreen();
    } else {
      child = Login();
    }

    return Scaffold(
      body: child,
    );
  }
}
