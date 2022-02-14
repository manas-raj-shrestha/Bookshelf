import 'package:flutter_test/flutter_test.dart';
import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/view_models/task_view_model.dart';

import 'mocks/mock_firebase_service.dart';

void main() {
  group('Home view model logic test', () {
    TaskViewModel taskViewModel = TaskViewModel(MockFirebaseService());

    test('When Fetched Tasks,Then Return Corrent Task Count', () async {
      await taskViewModel.fetchTasks();
      expect(taskViewModel.tasks.length, 3);
    });

    test('When Added Tasks, Return Correct Task Count', () async {
      Task newTask = Task(
          id: null,
          description: 'New Task Description',
          title: 'New Task Title',
          completedAt: null);

      await taskViewModel.addTask(newTask);

      expect(taskViewModel.tasks.length, 4);
    });

    test('When Deleted Tasks,Then Remove Respective Task From List', () async {
      await taskViewModel.deleteTask(Task(id: '200'));

      expect(taskViewModel.tasks.length, 3);
    });

    test(
        'Given Task With Unmatched Id, When Deleted Task,Then Remove Respective Task From List',
        () async {
      await taskViewModel.deleteTask(Task(id: '500'));

      expect(taskViewModel.tasks.length, 3);
    });

    test(
        'Given Correct Task, When Edited Task, Then Update Respective Task In The List',
        () async {
      Task edittedTask = Task(
        id: '300',
        title: '[Editted] Test task Uncompleted task',
        description: '[Editted] Test task description uncompleted task',
        completedAt: null,
      );

      await taskViewModel.updateTask(edittedTask);

      Task updatedTask = taskViewModel.tasks
          .firstWhere((element) => element.id == edittedTask.id);

      expect(updatedTask.title, edittedTask.title);
    });
  });
}
