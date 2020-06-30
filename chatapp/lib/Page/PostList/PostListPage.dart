import 'package:chatapp/Page/PostList/PostListTile.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Page/PostList/PostListViewModel.dart';
import 'package:chatapp/Page/PostList/sendPostArea.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostListPage extends StatefulWidget{

  PostListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostListState();
}

class _PostListState extends State<PostListPage>{

  // 投稿リスト
  List<Widget> postWidgetList = [];

  // viewModel
  PostListViewModel _viewModel;
  // 投稿エリア
  SendPostArea _sendPostArea;

  @override
  void initState(){
    super.initState();
    print("PostListPage initState");

    // 初期化
    _viewModel =    PostListViewModel();
    _sendPostArea = SendPostArea(viewModel: _viewModel);
  }


  // 投稿セルの作成
  List<PostListTile> _makePostCells(AsyncSnapshot<QuerySnapshot> snapshot){

    // viewModelより取得
    var documents = snapshot.data.documents;
    List<PostListTile> list = _viewModel.getPost(documents);
    return list;
  }


  @override
  Widget build(BuildContext context) {
    String talkRoom = _viewModel.getTalkRoom();
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    // トークルームを指定
                    stream: Firestore.instance.collection("rooms").document(talkRoom).collection(talkRoom).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(snapshot.hasError){
                        print(snapshot.error);
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          return ListView(
                            children: _makePostCells(snapshot),
                          );
                      }
                    },
                  )
              ),
            ),
            // ここに投稿フィールドが来る
            _sendPostArea
          ],
        )
    );
  }
}