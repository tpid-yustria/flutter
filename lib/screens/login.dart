import 'package:job_finder/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:job_finder/service/api-login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
// Mendeklarasikan beberapa variabel dan state untuk digunakan di dalam widget
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email, password;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

// Membuat fungsi showHide untuk menampilkan atau menyembunyikan password
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

// Membuat fungsi _showMsg untuk menampilkan pesan pada snackbar
  _showMsg(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                  children: [
                  Text(
                  "Welcome Back",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text("Enter your credential to login"),
                  ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                        initialValue: "yustria@mailinator.com",
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            filled: true,
                            prefixIcon: Icon(Icons.person)),
                        validator: (emailValue) {
                          if (emailValue?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          email = emailValue;
                          return null;
                        }
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: "password",
                      keyboardType: TextInputType.text,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_secureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                      ),
                      validator: (passwordValue) {
                        if (passwordValue?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        password = passwordValue;
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          _login(); //minjilinkin fingsi ligin siit simiwi inpit tidik null
                        }
                      },
                      child: Text(
                        _isLoading ? 'Proccessing..' : 'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Forgot password?")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account? "),
                  TextButton(onPressed: () {}, child: Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    // mendefinisikan method _login() yang bersifat asynchronous
    setState(() {
      // mengubah nilai variabel _isLoading menjadi true
      _isLoading = true;
    });

    var data = {
      'email': email.toString(),
      'password': password.toString()
    }; // mendefinisikan sebuah variabel data yang berisi email dan password yang dikirimkan ke server

    final res = await Network().postRequest(
        route: '/login',
        data: data); // melakukan request POST ke endpoint /login pada server dengan menggunakan data yang sudah didefinisikan sebelumnya
    final response = jsonDecode(res.body); // mengubah respon dari server yang diterima JSON format menjadi object atau data

    if (response['status'] == 200) {
      // jika status respon dari server adalah 200, maka login berhasil
      _showMsg(response['message']
          .toString()); // menampilkan pesan berhasil dengan menggunakan method _showMsg()
      SharedPreferences preferences = await SharedPreferences
          .getInstance(); // membuat instance dari class SharedPreferences
      await preferences.setInt(
          "userId",
          response['data']
          ['id']); // menyimpan id user ke dalam SharedPreferences
      await preferences.setString(
          "userName",
          response['data']
          ['name']); // menyimpan nama user ke dalam SharedPreferences
      await preferences.setString(
          "userEmail",
          response['data']
          ['email']); // menyimpan email user ke dalam SharedPreferences
      await preferences.setString("token",
          response['token']); // menyimpan token user ke dalam SharedPreferences
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        // melakukan perpindahan halaman ke halaman Home
        builder: (context) => MainScreen(),
      ));
    } else {
      // jika status respon dari server bukan 200, maka login gagal
      _showMsg(response[
      'message']); // menampilkan pesan gagal dengan menggunakan method _showMsg()
    }

    print(jsonDecode(res
        .body)); // menampilkan body dari respon server dalam bentuk JSON pada console
    setState(() {
      // mengubah nilai variabel _isLoading menjadi false
      _isLoading = false;
    });
  }
  }
