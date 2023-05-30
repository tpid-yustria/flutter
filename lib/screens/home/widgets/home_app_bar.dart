import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_finder/service/api-login.dart';
import 'dart:convert';

class HomeAPpBar extends StatefulWidget {
  const HomeAPpBar({Key? key}) : super(key: key);

  @override
  _HomeAPpBarState createState() => _HomeAPpBarState();
}

class _HomeAPpBarState extends State<HomeAPpBar> {
  bool isLoading = false;

  late SharedPreferences sharedPreferences;
  var name = " ";

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData().then((value) {
      setState(() {
        name = value;
      });
    });
  }
  _loadUserData() async {
    setState(() {
      isLoading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('userName').toString();
    return name;
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, right: 25, left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Home',
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30,right: 10),
                transform: Matrix4.rotationZ(100),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar.png',
                  width: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}