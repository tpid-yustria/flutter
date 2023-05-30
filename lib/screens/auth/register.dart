import 'package:flutter/material.dart';
import 'package:job_finder/service/api-login.dart';
import 'dart:convert';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;
  var name, email, password;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

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
                    "Register",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text("Enter your credential to register"),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: "Full Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            filled: true,
                            prefixIcon: Icon(Icons.account_box)),
                        validator: (nameValue) {
                          if (nameValue?.isEmpty ?? true) {
                            return 'Please enter your full name';
                          }
                          name = nameValue;
                          return null;
                        }
                    ),
                    SizedBox(height: 10),
                    TextFormField(
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
                          _register();
                        }
                      },
                      child: Text(
                        _isLoading ? 'Proccessing..' : 'Register',
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
              // TextButton(onPressed: () {}, child: Text("Forgot password?")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Does has an account? "),
                  TextButton(onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Register(),
                    ));
                  },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'name': name, 'email': email, 'password': password};
    final res = await Network().postRequest(route: '/register', data: data);
    final response = jsonDecode(res.body);
    if (response['status'] == 200) {
      _showMsg(response['message']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Login(),
      ));
    }

    print(jsonDecode(res.body));
    setState(() {
      _isLoading = false;
    });
  }
}
