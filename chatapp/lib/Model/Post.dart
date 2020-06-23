import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  String    _profileName;
  String    _iconName;
  String    _content;
  Timestamp _createTime;

  init(String profileName, String iconName, String content, Timestamp createTime){
    this._profileName = profileName;
    this._iconName    = iconName;
    this._content     = content;
    this._createTime  = createTime;
  }

  String getProfileName(){
    return this._profileName;
  }
  String getIconName(){
    return this._iconName;
  }
  String getContent(){
    return this._content;
  }
  String getCreateTime(){
    
  }



}
