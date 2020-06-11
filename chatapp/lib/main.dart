import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 静的な部分を構築
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final title   = "サンプルのタイトル";
  final product = "メッセージはここ";
  @override
  Widget build(BuildContext context) {
    //　マテリアルアプリを返す（クパチーノにもできる？）
    return MaterialApp(
      // タイトルを設定
      title: 'tsumayoji App',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // homeArea(Scaffoldで、ベーシックなマテリアルデザインにできる）
      home: MyHomePage(
        title: this.title,
        product: this.product,
      )
    );
  }
}

// ウィジェットクラス
class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title, this.product}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String product;

  // ここで、ステートを読み込む
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// ステートクラス（ウィジェットで読み込ませる）
class _MyHomePageState extends State<MyHomePage> {

  Product _product;

  static final _products = [Product("りんご", 200), Product("みかん", 300)];
  // 表示するもの

  @override
  void initState(){
    super.initState();
    _product = _products.first;
  }

  void _setProduct(){
    setState(() {
      // シャッフル
      _product = (_products..shuffle()).first;
    });

}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Text(_product.toString(), style: TextStyle(fontSize: 32.0),),
      // 右下にボタンが出せる
      floatingActionButton: FloatingActionButton(
        onPressed: _setProduct,  // タップした時
        tooltip: 'set product.', //
        child: Icon(Icons.star), //
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// オブジェクトを定義
class Product{
  String _fruit;
  int    _price;

  // コンストラクタ
  Product(this._fruit, this._price) :super();

  // 商品、価格
  @override
  String toString(){
    return this._fruit + this._price.toString() + "Yen";
  }
}

