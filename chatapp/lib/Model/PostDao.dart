import 'package:chatapp/Model/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PostDao{

  // 投稿を返却
  static List<Post> readPost(List<DocumentSnapshot> documents){

    List<Post> postList = [];
    for (var document in documents){
      var post = Post.fromMap(document.data);
      postList.add(post);
    }
    return postList;
  }

  // 投稿追加
  static void addPost(Firestore firestore, String talkRoom, String profileName, String iconName, String content){

    firestore.collection("rooms").document(talkRoom).collection(talkRoom).add({
      "profileName": profileName,
      "iconName"   : iconName,
      "createTime" : DateTime.now(),
      "content"    : content
    });
  }


}