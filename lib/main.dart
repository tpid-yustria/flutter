import 'package:flutter/material.dart';
import 'package:helloworld/data/model/article.dart';
import 'package:helloworld/ui/article_detail_page.dart';
import 'package:helloworld/ui/article_list_page.dart';
import 'package:helloworld/ui/article_web_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ArticleListPage(),
        'article_web': (context) =>
            ArticleWebView(
              // url: ModalRoute.of(context)!.settings.arguments as String
            ),
        '/article_detail': (context) =>
            ArticleDetailPage(
              // ModalRoute.of(context)!.settings.arguments as Article
            ),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}