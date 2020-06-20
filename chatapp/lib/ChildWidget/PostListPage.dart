import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostListPage extends StatefulWidget{

  PostListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends State<PostListPage>{

  // アイコン用
  final iconList = {
    "account_circle": Icons.account_circle,
    "audiotrack"    : Icons.audiotrack,
    "android"       : Icons.android,
    "home"          : Icons.home,
    "bluetooth"     : Icons.bluetooth
  };
  // 投稿リスト
  List<Widget> postList = [];

  /* パラメータ　*/
  String _talkRoom    = "room1"; // トークルーム設定
  String _profileName = "";      // アカウント名
  String _iconName    = "";      // アイコン

  // TextField用
  TextEditingController _textEditingController;

  @override
  void initState(){
    super.initState();

    // コントローラ初期化
    _textEditingController = TextEditingController();
    _getAccountData();
  }

  void _getAccountData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _profileName = pref.getString("profileName");
    _iconName    = pref.getString("iconName");
    print("${_profileName} ${_iconName}");
  }

  // 投稿セルの作成
  List<Widget> _makePostCell(AsyncSnapshot<QuerySnapshot> snapshot){

    List<Widget> list = [];
    
    var documents = snapshot.data.documents;
    documents.sort((a, b) => (b["createTime"]).compareTo(a["createTime"]));

    for(var document in documents){
      //var document = documents[i];
      var container = Container(
          padding: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            // 画像と、それ以外で分割
            child: Row(
              children: <Widget>[
                Container(
                  height: 80,
                  alignment: Alignment.topCenter,
                  child: Container(
                    width:  40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                    child: Icon(iconList[document["iconName"] ?? "account_circle"]),
                  ),
                ),
                // 情報系
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                                child: Text(document["profileName"] ?? "???",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800
                                    ))
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Text(""),
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(document["content"]),
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

      list.add(container);
    }
    return list;
  }


  // 投稿
  void _tapPostButton(){
    // 未入力ならダメ
    if(_textEditingController.text != "") {
      setState(() {
        print("firestore add");
        Firestore.instance.collection("rooms").document(_talkRoom).collection(_talkRoom).add({
          "profileName": _profileName,
          "iconName": _iconName,
          "createTime": DateTime.now(),
          "content": _textEditingController.text
        });
        _textEditingController.text = "";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    // トークルームを指定
                    stream: Firestore.instance.collection("rooms").document(_talkRoom).collection(_talkRoom).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasError){
                        print(snapshot.error);
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          return ListView(
                            children: _makePostCell(snapshot),
                          );
                      }
                    },
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
                                controller: _textEditingController,
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
                          onPressed: _tapPostButton,
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