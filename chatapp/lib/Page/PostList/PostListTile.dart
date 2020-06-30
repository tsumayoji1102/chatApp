import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Model/Post.dart';

// 静的でOK（変更が加わらないので）
class PostListTile extends StatelessWidget{

  // アイコン用
  final iconList = {
    "account_circle": Icons.account_circle,
    "audiotrack"    : Icons.audiotrack,
    "android"       : Icons.android,
    "home"          : Icons.home,
    "bluetooth"     : Icons.bluetooth
  };

  // モデルに従う
  PostListTile({@required this.post});
  final Post post;

  @override
  Widget build(BuildContext context){
    return Container(
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
                  child: Icon(iconList[post.iconName]),
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
                              child: Text(post.profileName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800
                                  ))
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(post.getCreateTime()),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(post.content),
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
  }
}
