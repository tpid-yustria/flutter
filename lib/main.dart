import 'package:flutter/material.dart';
import 'package:helloworld/detail_screen.dart';
import 'package:helloworld/main_screen.dart';
import 'package:helloworld/provider/done_tourism_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(),
    //   // home: const DetailScreen(),
    //   home: MainScreen(),
    // );
    return ChangeNotifierProvider(
      create: (context) => DoneTourismProvider(),
      child: MaterialApp(
        title: 'Contacts',
        theme: ThemeData(),
        home: MainScreen(),
      )
    );
  }
}
