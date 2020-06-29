import 'package:flutter/material.dart';
// 他ファイル読み込み
import 'package:chatapp/Page/PostList/PostListPage.dart';
import 'package:chatapp/Page/Profile/ProfilePage.dart';

// ウィジェットクラス
class HomePage extends StatefulWidget {

  // 初期化
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  // ここで、ステートを読み込む
  @override
  _HomePageState createState() => _HomePageState();
}

// ステートクラス（ウィジェットで読み込ませる）
class _HomePageState extends State<HomePage>{

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