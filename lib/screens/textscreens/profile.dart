import 'package:flutter/material.dart';
import 'package:job_finder/constant/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_finder/service/api-login.dart';
import 'package:job_finder/screens/auth/login.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences sharedPreferences;
  late String token;
  String name='';
  String email='';

  _loadUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token').toString();
    name = sharedPreferences.getString('userName').toString();
    email = sharedPreferences.getString('userEmail').toString();
    return [name, email];
  }

  @override
  void initState() {
    super.initState();
    _loadUserData().then((value) {
      setState(() {
        name = value[0];
        email = value[1];
      });
    });
  }

  _showMsg(String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context , child) {
        return Expanded(
          child: Column(
            children: <Widget>[
              Container(
                height: 10 * 10,
                width: 10 * 10,
                margin: EdgeInsets.only(top: 10 * 3),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 10 * 5,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 10 * 2.5,
                        width: 10 * 2.5,
                        decoration: BoxDecoration(
                          color: kAccentColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          heightFactor: 10 * 1.5,
                          widthFactor: 10 * 1.5,
                          child: Icon(
                            LineAwesomeIcons.pen,
                            color: kDarkPrimaryColor,
                            size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10 * 2),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10 * 0.5),
              Text(
                email,
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                ),
              ),
              SizedBox(height: 10 * 2),
              Container(
                height: 10 * 4,
                width: 10 * 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * 3),
                  color: kAccentColor,
                ),
                child: Center(
                  child: Text(
                    'Upgrade to PRO',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(10 * 1.5),
                      fontWeight: FontWeight.w400,
                      color: kDarkPrimaryColor,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: kSpacingUnit.w * 5),
                  Container(
                    height: kSpacingUnit.w * 5.5,
                    margin: EdgeInsets.symmetric(
                      horizontal: kSpacingUnit.w * 4,
                    ).copyWith(
                      bottom: kSpacingUnit.w * 2,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: kSpacingUnit.w * 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                      color: kLightSecondaryColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          LineAwesomeIcons.cog,
                          size: kSpacingUnit.w * 2.5,
                        ),
                        SizedBox(width: kSpacingUnit.w * 1.5),
                        Text(
                          "Setting",
                          style: kTitleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LineAwesomeIcons.angle_right,
                              size: kSpacingUnit.w * 2.5,
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: kSpacingUnit.w * 5.5,
                    margin: EdgeInsets.symmetric(
                      horizontal: kSpacingUnit.w * 4,
                    ).copyWith(
                      bottom: kSpacingUnit.w * 2,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: kSpacingUnit.w * 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                      color: kLightSecondaryColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          LineAwesomeIcons.alternate_sign_out,
                          size: kSpacingUnit.w * 2.5,
                        ),
                        SizedBox(width: kSpacingUnit.w * 1.5),
                        Text(
                          "Logout",
                          style: kTitleTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              logout();
                            },
                            icon: Icon(
                              LineAwesomeIcons.angle_right,
                              size: kSpacingUnit.w * 2.5,
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        );
      },
    );
  }

  void logout() async {
    if (sharedPreferences != null) {
      final res = await Network().postRequest(
        route: '/logout', // alamat endpoint logout
        data: {}, // data kosong karena logout tidak memerlukan data
        token: token, // menambahkan token untuk otorisasi
      );
      final result = jsonDecode(res.body); // mengubah hasil response ke dalam bentuk JSON
      if (result['status'] == 200) {
        _showMsg(result['message']); // menampilkan pesan sukses pada user
        sharedPreferences.clear(); // menghapus data shared preference
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Login(),
        ));
      } else {
        _showMsg(result['message']); // menampilkan pesan error pada user
      }
    }
  }
}