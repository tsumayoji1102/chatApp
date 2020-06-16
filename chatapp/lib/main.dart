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
  
  List<Widget> postList = [
    Container(
      height: 100,
    )
  ];
  
  @override
  void initState(){
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                child: ListView(
                  children: <Widget>[
                    
                  ],
                )
              ),
            ),
            Container(
                height: 80,
                color: Colors.grey[20gio0],
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
                                  fontWeight: FontWeight.w200
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



