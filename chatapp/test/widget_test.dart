// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:chatapp/Page/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // テストの実行
    await tester.pumpWidget(MyApp()); // appのインスタンス作成
    await tester.pump();              // フレームへのトリガー(launch)

  });
}

void checkStartScreenTest(){
  testWidgets('check start screen test', (WidgetTester tester) async {
    // テストの実行
    await tester.pumpWidget(MyApp()); // appのインスタンス作成
    await tester.pump();              // フレームへのトリガー(launch)

    expect(find.text("SNS風アプリ"), findsOneWidget);
    expect(find.text("投稿"), findsOneWidget);
  });
}

