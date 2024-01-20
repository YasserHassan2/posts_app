// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posts_app/app/app.dart';
import 'package:posts_app/app/di.dart';
import 'package:posts_app/domain/usecase/posts_usecase.dart';

import 'package:posts_app/main.dart';
import 'package:posts_app/presentation/home/home_view.dart';

void main() {
  testWidgets('test widgets of main screen', (WidgetTester tester) async {
    //Arrange - Pump MyApp() widget to tester
    // PostsUseCase postsUseCase = instance<PostsUseCase>();
    // await tester.pumpWidget(MyApp());
    //
    // //Act - Find TextView by type
    // var textView = find.byType(Text);
    //
    // //Assert - Check that button widget is present
    // expect(textView, findsOneWidget);
  });
}
