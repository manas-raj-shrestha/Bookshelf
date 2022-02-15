import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/ui/task/tasks_screen.dart';

import 'task_screen_widget_test.mocks.dart';

@GenerateMocks([],
    customMocks: [MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)])
void main() {
  testWidgets('When Clicked Add Button, Then Navigate To Task Page',
      (WidgetTester tester) async {
    setupInjections();
    var mockObserver = MockNavigatorObserver();
    var addButtonFinder = find.byKey(const ValueKey('add_task_button'));
    await tester.pumpWidget(MaterialApp(
      home: const TasksPage(isCompletedPage: false, title: 'All Tasks'),
      navigatorObservers: [mockObserver],
    ));

    await tester.tap(addButtonFinder);

    verify(mockObserver.didPush(any, any));
  });
}
