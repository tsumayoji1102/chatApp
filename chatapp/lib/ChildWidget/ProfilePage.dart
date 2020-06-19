import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';


// プロフィールページ
class ProfilePage extends StatefulWidget{

  ProfilePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage>{

  final iconList = {"account_circle": Icons.account_circle,
    "audiotrack"    : Icons.audiotrack,
    "android"       : Icons.android,
    "home":           Icons.home,
    "bluetooth"      :Icons.bluetooth
  };

  String _defaultProfileName = "";
  String _defaultIconName    = "";
  String _selectedIconName   = "";

  // UIパーツ
  TextEditingController textController = TextEditingController();
  Icon _icon;


  @override
  void initState(){
    super.initState();
    print("ProfilePage initState ${DateTime.now()}");
    getProfile();
  }

  // セッター
  void setProfileName(String profileName) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("profileName", profileName);

  }

  // プロフィール名反映
  void getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      // 名前
      var name = pref.getString("profileName");
      print("get name '${name}'");
      if(name == null){
        pref.setString("profileName", "default");
        _defaultProfileName = "default";
        textController.text = "default";
      }else{
        _defaultProfileName = name;
        textController.text = name;
      }
      // アイコン
      var iconName = pref.getString("iconName");
      print("get iconName ${iconName}");
      if(iconName == null){
        pref.setString("iconName", "account_circle");
        _icon = Icon(iconList["account_circle"], size: 100);
        _defaultIconName  = "account_circle";
        _selectedIconName = "account_circle";
      }else{
        _icon = Icon(iconList[iconName], size: 100);
        _defaultIconName  = iconName;
        _selectedIconName = iconName;
      }
    });
  }

  void _tapIconButton(){
    print("tapIconButton ${DateTime.now()}");
    List<Widget> iconWidgetList = [];
    for(var key in iconList.keys){
      var childWidget = ListTile(
        leading: Icon(iconList[key], size: 40),
        title: Text(key),
        onTap: (){
          setState((){
            _icon = Icon(iconList[key], size: 100);
            _selectedIconName = key;
            Navigator.pop(context);
          });
        },
      );
      iconWidgetList.add(childWidget);
    }
    // モーダル表示
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) =>
            Container(
              child: ListView(
                children: iconWidgetList,
              ),
            )
    );

  }

  // 保存ボタンタップ時
  void _tapSaveButton() async{
    print("tapButton ${DateTime.now()}");
    SharedPreferences pref = await SharedPreferences.getInstance();
    // プロフィール名セット
    if(_defaultProfileName != textController.text){
      pref.setString("profileName", textController.text);
    }
    // 画像をセット
    if(_defaultIconName != _selectedIconName){
      pref.setString("iconName", _selectedIconName);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              color: Colors.grey[300],
              height: 240,
              child: ListView(
                // スクロールできなくする
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Center(
                      child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(75))
                          ),
                          child: FlatButton(
                            onPressed: _tapIconButton,
                            shape: CircleBorder(
                                side: BorderSide(color: Colors.grey[300])
                            ),
                            child: _icon,
                          )
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      child: Center(
                        child: Text("アイコンを変更", style:
                        TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                        ),
                      )
                  )
                ],
              )
          ),
          Container(
              child: Container(
                  padding: EdgeInsets.all(20),
                  // プロフィール欄
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Text("プロフィール名",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),),
                      ),
                      Container(
                        height: 80,
                        child: TextField(
                          controller: textController,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      )
                    ],
                  )
              )
          ),
          // ボタン
          Container(
            height: 100,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: FlatButton(
                      onPressed: _tapSaveButton,
                      child: Text("保存", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),)
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}