import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';

class Post{

  Post({
    @required this.profileName,
    @required this.iconName,
    @required this.content,
    @required this.createTime
  });

  String    profileName;
  String    iconName;
  String    content;
  DateTime  createTime;

  // firestoreから直にオブジェクト生成
  factory Post.fromMap(Map<dynamic, dynamic> value){
    return Post(
      profileName: value["profileName"],
      iconName:    value["iconName"],
      content:     value["content"],
      createTime: (value["createTime"] as Timestamp).toDate()
    );
  }

  // DateTimeを変換
  String getCreateTime(){
    initializeDateFormatting("ja_JP");
    var format = DateFormat('yyy/MM/dd HH:mm', 'ja_JP');
    var createTime = format.format(this.createTime);
    return createTime;
  }
}
