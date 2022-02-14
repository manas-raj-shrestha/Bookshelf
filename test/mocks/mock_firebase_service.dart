import 'dart:math';

import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/core/services/firebase_service.dart';

class MockFirebaseService extends FirebaseService {
  @override
  Future<String> addTask(Task task) async {
    return Future.value(Random(200).toString());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    //Do nothing
  }

  @override
  Future<void> editTask(Task task) async {
    //Do nothing
  }

  @override
  Future<List<Task>> get tasks async {
    return Future.value([
      Task(
          id: '200',
          title: 'Test task',
          description: 'Test task description',
          completedAt: DateTime.now().toIso8601String()),
      Task(
        id: '100',
        title: 'Test task Second',
        description: 'Test task description second',
        completedAt: DateTime.now().toIso8601String(),
      ),
      Task(
        id: '300',
        title: 'Test task Uncompleted task',
        description: 'Test task description uncompleted task',
        completedAt: null,
      ),
    ]);
  }
}
