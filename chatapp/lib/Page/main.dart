import 'package:flutter/material.dart';
import 'package:chatapp/Page/Home/HomePage.dart';

void main() {
  runApp(MyApp());
}

// 静的な部分を構築
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final title   = "SNS風アプリ";
  @override
  Widget build(BuildContext context) {
    //　マテリアルアプリを返す（クパチーノにもできる？）
    return MaterialApp(
      // タイトルを設定
      title: 'tsumayoji App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomePage(
        title: this.title,
      ),
      // ここで画面遷移のrouteを設定できる
      initialRoute: "/",
    );
  }
}





