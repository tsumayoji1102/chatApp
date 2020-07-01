import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:chatapp/Page/PostList/PostListViewModel.dart';

class SendPostArea extends StatefulWidget{
  SendPostArea({Key key, this.viewModel}) : super(key: key);

  final PostListViewModel viewModel;
  @override
  State<StatefulWidget> createState() => _SendPostArea(viewModel: this.viewModel);
}

class _SendPostArea extends State<SendPostArea>{

  _SendPostArea({@required this.viewModel});
  PostListViewModel viewModel;
  // コントローラ初期化
  TextEditingController _textEditingController;

  @override
  void initState(){
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context){
    return Container(
        height: 80,
        color: Colors.grey[400],
        padding: EdgeInsets.all(15),
        child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 20, 10),
                    child: Center(
                      child: TextField(
                        controller: _textEditingController,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    )
                ),
              ),
              FlatButton(
                  color: Colors.blue,
                  onPressed: _tapPostButton,
                  child: Container(
                    child: Text("投稿", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white), // 丸みをつける
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(color: Colors.blue)
                  )
              ),
            ]
        )
    );
  }

  // 投稿
  void _tapPostButton(){
    // 未入力ならダメ
    if(_textEditingController.text != "") {
      setState(() {
        print("firestore add");
        // 追加
        viewModel.addPost(_textEditingController.text);
        _textEditingController.text = "";
      });
    }
  }
}
