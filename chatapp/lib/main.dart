import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// default用
import 'package:shared_preferences/shared_preferences.dart';
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

  final iconList = {"account_circle": Icons.account_circle,
                    "audiotrack"    : Icons.audiotrack,
                    "android"       : Icons.android,
                    "home":           Icons.home,
                    "bluetooth"      :Icons.bluetooth
  };

  String _defaultProfileName = "";
  String _defaultIconName    = "";
  String _selectedIconName   = "";

  // UIパーツ
  TextEditingController textController = TextEditingController();
  Icon _icon;


  @override
  void initState(){
    super.initState();
    print("ProfilePage initState ${DateTime.now()}");
    getProfile();
  }

  // セッター
  void setProfileName(String profileName) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("profileName", profileName);

  }

  // プロフィール名反映
  void getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      // 名前
      var name = pref.getString("profileName");
      print("get name '${name}'");
      if(name == null){
        pref.setString("profileName", "default");
        _defaultProfileName = "default";
        textController.text = "default";
      }else{
        _defaultProfileName = name;
        textController.text = name;
      }
      // アイコン
      var iconName = pref.getString("iconName");
      print("get iconName ${iconName}");
      if(iconName == null){
        pref.setString("iconName", "account_circle");
        _icon = Icon(iconList["account_circle"], size: 100);
        _defaultIconName  = "account_circle";
        _selectedIconName = "account_circle";
      }else{
        _icon = Icon(iconList[iconName], size: 100);
        _defaultIconName  = iconName;
        _selectedIconName = iconName;
      }
    });
  }

  void _tapIconButton(){
    print("tapIconButton ${DateTime.now()}");
    List<Widget> iconWidgetList = [];
    for(var key in iconList.keys){
      var childWidget = ListTile(
        leading: Icon(iconList[key], size: 40),
        title: Text(key),
        onTap: (){
          setState((){
            _icon = Icon(iconList[key], size: 100);
            _selectedIconName = key;
            Navigator.pop(context);
          });
        },
      );
      iconWidgetList.add(childWidget);
    }
    // モーダル表示
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) =>
            Container(
              child: ListView(
                children: iconWidgetList,
              ),
            )
        );

  }

  // 保存ボタンタップ時
  void _tapSaveButton() async{
    print("tapButton ${DateTime.now()}");
    SharedPreferences pref = await SharedPreferences.getInstance();
    // プロフィール名セット
    if(_defaultProfileName != textController.text){
      pref.setString("profileName", textController.text);
    }
    // 画像をセット
    if(_defaultIconName != _selectedIconName){
      pref.setString("iconName", _selectedIconName);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[300],
              height: 240,
              child: ListView(
                // スクロールできなくする
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(75))
                        ),
                        child: FlatButton(
                          onPressed: _tapIconButton,
                          shape: CircleBorder(
                            side: BorderSide(color: Colors.grey[300])
                          ),
                          child: _icon,
                        )
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Center(
                      child: Text("アイコンを変更", style:
                      TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                      ),
                    )
                  )
                ],
              )
            ),
            Container(
              child: Container(
                padding: EdgeInsets.all(20),
                // プロフィール欄
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(
                      height: 30,
                      child: Text("プロフィール名",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),),
                    ),
                    Container(
                      height: 80,
                      child: TextField(
                        controller: textController,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                )
              )
            ),
            // ボタン
            Container(
              height: 100,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: FlatButton(
                    onPressed: _tapSaveButton,
                    child: Text("保存", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),)
                  )
                ),
              ),
            )
          ],
        ),
    );
  }
}



