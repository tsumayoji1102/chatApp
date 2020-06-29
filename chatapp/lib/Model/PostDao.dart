import 'package:chatapp/Model/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class PostDao{

  // 投稿取得
  static Future<List<Post>> readPost(Firestore firestore, String talkRoom) async{
     // 取得
     var stream = firestore.collection("rooms").document(talkRoom).collection(talkRoom).snapshots();

     stream.listen((snapshot) {
       // ドキュメントを作成
       var documents = snapshot.documents;
       documents.sort((a, b) => (b["createTime"] as Timestamp).compareTo(a["createTime"]));

       // 投稿リスト作成
       List<Post> list = [];
       for (var document in documents){
         var post = Post(
             document.data["profileName"],
             document.data["iconName"],
             document.data["content"],
             document.data["createTime"]);

         list.add(post);
       }
       return Future.value(list);
     });
  }

  static void addPost(Firestore firestore, String talkRoom, String profileName, String iconName, String content){

    firestore.collection("rooms").document(talkRoom).collection(talkRoom).add({
      "profileName": profileName,
      "iconName"   : iconName,
      "createTime" : DateTime.now(),
      "content"    : content
    });
  }


}