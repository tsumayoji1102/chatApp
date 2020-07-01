import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileViewModel{

  SharedPreferences pref;
  String defaultProfileName;
  String defaultIconName;

  ProfileViewModel(){
    initPref();
  }

  void initPref() async{
    pref = await SharedPreferences.getInstance();
  }

  // プロフィール名セット
  void setProfileName(String profileName){
    pref.setString("profileName", profileName);
  }

  // プロフィール名セット
  void setIconName(String iconName){
    pref.setString("iconName", iconName);
  }

  String getProfileName(){
    // 名前
    var name = pref.getString("profileName");
    print("get name '${name}'");
    if(name == null){
      pref.setString("profileName", "default");
      return "default";
    }else{
      return name;
    }
  }

  String getIconName(){
    // アイコン
    var iconName = pref.getString("iconName");
    print("get iconName ${iconName}");

    if(iconName == null){
      pref.setString("iconName", "account_circle");
      return "account_circle";
    }else{
      return iconName;
    }
  }
}
