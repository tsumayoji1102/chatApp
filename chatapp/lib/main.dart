import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// 画像用にimport
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
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

class PostListPage extends StatefulWidget{

  PostListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends State<PostListPage>{
  
  List<Widget> postList = [];
  
  @override
  void initState(){
    super.initState();

    for(var i = 0; i < 10; i ++){
      // 投稿
      var container = Container(
        height: 200,
        padding: EdgeInsets.all(10),
        child: Container(
            padding: EdgeInsets.all(10),
            // 画像と、それ以外で分割
            child: Row(
              children: <Widget>[
                // アイコン
                Container(
                  alignment: Alignment.topCenter,
                  width:  40,
                  child: Container(
                    //color: Colors.blue,
                    padding: EdgeInsets.all(1),
                    width:  40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Icon(Icons.android),
                  ),
                ),
                // 情報系
                Expanded(
                  // 縦
                  child: Column(
                    children: <Widget>[
                      // 1行目
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                              child: Text("accountName",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800
                              ))
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text("yyyy/MM/dd \nHH:mm"),
                          )
                        ],
                      ),
                      // 二行目
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text("ここに内容が入るんだよおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおお"),
                      )
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[200]),
                borderRadius: BorderRadius.circular(10)
            ),
          )

      );
      postList.add(container);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    shrinkWrap: true,
                    children: postList,
                  )
              ),
            ),
            Container(
                height: 80,
                color: Colors.grey[400],
                padding: EdgeInsets.all(15),
                child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 20, 10),
                            child: Center(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            )
                        ),
                      ),
                      FlatButton(
                          color: Colors.blue,
                          onPressed: ((){
                            print("pressed");
                          }),
                          child: Container(
                            child: Text("投稿", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white), // 丸みをつける
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              side: BorderSide(color: Colors.blue)
                          )
                      ),
                    ]
                  )
              )
           ],
          )
    );
  }
}


// プロフィールページ
class ProfilePage extends StatefulWidget{

  ProfilePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Text("ここに画像が入る",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: Text("ここに名前が入る",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600
                  ),
                )
              )
            )
          ],
        ),
    );
  }
}



