// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todolist/database/database.dart';

import 'package:manabie_todolist/main.dart';
import 'package:manabie_todolist/model/task_model.dart';
import 'package:manabie_todolist/modules/home/home_view.dart';
import 'package:manabie_todolist/modules/home/widgets/task_detail_widget.dart';
import 'package:manabie_todolist/modules/home/widgets/todo_list_item_widget.dart';

void main() {

  test('Check DB', () async {
    await DatabaseHelper.deleteAll();
    List<TaskModel> tasks = await DatabaseHelper.getListTaskModel();
    expect(tasks, isEmpty);

    await DatabaseHelper.insertTask(TaskModel(title: "Test Title", description: "Test Description", createdDate: "05-05-2022"));
    expect(await DatabaseHelper.getListTaskModel(), isNotEmpty);
    expect((await DatabaseHelper.getListTaskModel())[0].title, "Test Title");

    await DatabaseHelper.updateTask(
        TaskModel(id: (await DatabaseHelper.getListTaskModel())[0].id, title: "Test Title Updated", description: "Test Description", createdDate: "05-05-2022"));
    expect((await DatabaseHelper.getListTaskModel())[0].title, "Test Title Updated");
  });

  testWidgets('Check is HomeView', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(HomeView), findsOneWidget);
  });

  testWidgets('Check empty list', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    expect(find.text("Không có công việc"), findsOneWidget);
    expect(find.byType(TodoListItemWidget), findsNothing);
  });

  testWidgets('Check open bottomsheet & add task', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));

    // Check open Bottomsheet
    IconButton button = find.widgetWithIcon(IconButton, CupertinoIcons.add).evaluate().first.widget as IconButton;
    button.onPressed?.call();
    await tester.pump();
    expect(find.byType(TaskDetailWidget), findsOneWidget);
    expect(find.byKey(ValueKey("titleTextField")), findsOneWidget);
    expect(find.byKey(ValueKey("descriptionTextField")), findsOneWidget);

    // Check no data
    GestureDetector gestureDetector = find.widgetWithText(GestureDetector, "Thêm").evaluate().first.widget as GestureDetector;
    gestureDetector.onTap?.call();
    await tester.pump();
    expect(find.byKey(ValueKey("SaveConfirmYesBtn")), findsNothing);
    expect(find.byKey(ValueKey("SaveConfirmNoBtn")), findsNothing);

  });
}
