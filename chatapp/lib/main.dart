import 'package:flutter/material.dart';

// 他ファイル読み込み
import 'package:chatapp/ChildWidget/PostListPage.dart';
import 'package:chatapp/ChildWidget/ProfilePage.dart';

import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;

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
      // homeArea(Scaffoldで、ベーシックなマテリアルデザインにできる）
      home: MyHomePage(
        title: this.title,
      ),
      // ここで画面遷移のrouteを設定できる
      initialRoute: "/",
    );
  }
}

// ウィジェットクラス
class MyHomePage extends StatefulWidget {

  // 初期化
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  // ここで、ステートを読み込む
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ステートクラス（ウィジェットで読み込ませる）
class _MyHomePageState extends State<MyHomePage>{

  final _selectedPage = [PostListPage(), ProfilePage()];
  int    _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    // 画面作成
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _selectedPage[_selectedIndex],
          ),
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text("投稿"),
                icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                title: Text("プロフィール"),
                icon: Icon(Icons.account_circle)
              )
            ],
            onTap: (int value){
              setState(() {
                _selectedIndex = value;
              });
            },
          )
        ],
      )
    );
  }
}



