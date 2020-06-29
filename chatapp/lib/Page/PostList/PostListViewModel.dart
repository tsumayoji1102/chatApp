import 'package:chatapp/Model/Post.dart';
import 'package:chatapp/Model/PostDao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostListViewModel{

  // 保持する値
  Firestore firestore;

  init(){
    firestore = Firestore.instance;
  }

  // 投稿リスト取得
  Future<List<Post>> getPost(String talkRoom) async{
    var postList = await PostDao.readPost(firestore, talkRoom);
    return Future.value(postList);
  }

  // 投稿
  void addPost(String talkRoom, String profileName, String iconName, String content){
    PostDao.addPost(firestore, talkRoom, profileName, iconName, content);
  }
}
