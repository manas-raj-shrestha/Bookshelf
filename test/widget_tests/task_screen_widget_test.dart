import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/ui/task/task_screen.dart';

import 'task_screen_widget_test.mocks.dart';

@GenerateMocks([],
    customMocks: [MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)])
void main() {
  testWidgets('When Given New Task, Should Pop To Previous Page',
      (WidgetTester tester) async {
    setupInjections();
    final mockObserver = MockNavigatorObserver();

    final titleField = find.byKey(const ValueKey('title_text_field'));
    final descriptionField =
        find.byKey(const ValueKey('description_text_field'));
    final actionButton = find.byKey(const ValueKey('action_button'));

    await tester.pumpWidget(MaterialApp(
      home: const TaskPage(),
      navigatorObservers: [mockObserver],
    ));
    await tester.enterText(titleField, 'New task sample title');
    await tester.enterText(descriptionField, 'New task sample description');
    await tester.tap(actionButton);
    await tester.pump();

    verify(mockObserver.didPop(any, any));
  });

  testWidgets(
      'When Given Task Via Constructor, Task Must Be Pre Filled Into Forms',
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(MaterialApp(
      home: TaskPage(
        task: Task(
          id: '300',
          title: '[Editted] Test task Uncompleted task',
          description: '[Editted] Test task description uncompleted task',
          completedAt: null,
        ),
      ),
      navigatorObservers: [mockObserver],
    ));

    expect(find.text('[Editted] Test task Uncompleted task'), findsOneWidget);
    expect(find.text('[Editted] Test task description uncompleted task'),
        findsOneWidget);
    expect(find.text('Update'), findsOneWidget);
  });

  testWidgets('When Given Completed Task, Switch Must Be Turned On',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskPage(
        task: Task(
          id: '300',
          title: '[Editted] Test task Uncompleted task',
          description: '[Editted] Test task description uncompleted task',
          completedAt: DateTime.now().toIso8601String(),
        ),
      ),
    ));

    final finder = find.byWidgetPredicate(
        (widget) =>
            widget is CupertinoSwitch &&
            widget.key == const ValueKey('completion_switch') &&
            widget.value == true,
        description: 'Switch is enabled');

    expect(finder, findsOneWidget);
  });

  testWidgets('When Given Incomplete Task, Switch Must Be Turned Off',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TaskPage(
        task: Task(
          id: '300',
          title: '[Editted] Test task Uncompleted task',
          description: '[Editted] Test task description uncompleted task',
          completedAt: null,
        ),
      ),
    ));

    final finder = find.byWidgetPredicate(
        (widget) =>
            widget is CupertinoSwitch &&
            widget.key == const ValueKey('completion_switch') &&
            widget.value == false,
        description: 'Switch is disabled');

    expect(finder, findsOneWidget);
  });
}
