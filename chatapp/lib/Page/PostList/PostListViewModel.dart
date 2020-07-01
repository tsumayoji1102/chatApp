
import 'package:chatapp/Model/PostDao.dart';
import 'package:chatapp/Page/PostList/PostListTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostListViewModel {

  // 保持する値
  Firestore firestore;
  // パラメータ
  String _talkRoom    = "room1"; // トークルーム設定
  String _profileName = "";      // アカウント名
  String _iconName    = "";      // アイコン

  // Initializer
  PostListViewModel(){
    firestore = Firestore.instance;
    // 初期化
    _getAccountData();
  }

  // トークルーム取得
  String getTalkRoom(){
    return _talkRoom;
  }

  void _getAccountData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    _profileName = pref.getString("profileName");
    _iconName    = pref.getString("iconName");
    print("${_profileName} ${_iconName}");
  }

  // 投稿リスト取得
  List<PostListTile> getPost(List<DocumentSnapshot> documents) {
    // モデル取得
    var postList = PostDao.readPost(documents);
    postList.sort((a, b) => b.createTime.compareTo(a.createTime));
    // 投稿一覧作成
    var postWidgetList = postList.map((post) => PostListTile(post: post))
        .toList();
    return postWidgetList;
  }

  // 投稿
  void addPost(String content) {
    PostDao.addPost(firestore, _talkRoom, _profileName, _iconName, content);
  }

}

