import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/core/services/firebase_service.dart';
import 'package:nytbooks/view_models/base_model.dart';

class TaskViewModel extends BaseModel {
  List<Task> tasks = [];

  List<Task> get completedTasks =>
      tasks.where((task) => task.isCompleted).toList();

  _ResultHolder? _resultHolder;

  _ResultHolder? get resultHolder => _resultHolder;

  Future fetchTasks() async {
    try {
      if (tasks.isEmpty) {
        changeState(ViewState.busy);
        notifyListeners();
        List<Task> tasksResponse = await FirebaseService.shared.tasks;
        tasks.addAll(tasksResponse);
        changeState(ViewState.idle);
      }
    } catch (e) {
      changeState(ViewState.error);
    } finally {
      notifyListeners();
    }
  }

  void clearResultHolder() => _resultHolder = null;

  Future addTask(Task task) async {
    try {
      String docId = await FirebaseService.shared.addTask(task);
      task.id = docId;

      tasks.add(task);
      _resultHolder = _ResultHolder(false, 'Task added successfully');
    } catch (e) {
      _resultHolder = _ResultHolder(false, 'Failed to add task!');
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      if (task.id != null) {
        await FirebaseService.shared.deleteTask(task.id!);
        tasks.removeWhere((element) => element.id == task.id);
        _resultHolder = _ResultHolder(false, 'Task deleted successfully');
      }
    } catch (error) {
      _resultHolder = _ResultHolder(true, 'Failed to delete task!');
    } finally {
      notifyListeners();
    }
  }

  Future updateTask(Task updatedTask) async {
    try {
      await FirebaseService.shared.editTask(updatedTask);
      tasks[tasks.indexWhere((element) => element.id == updatedTask.id)] =
          updatedTask;

      _resultHolder = _ResultHolder(false, 'Task updated successfully');
    } catch (e) {
      _resultHolder = _ResultHolder(true, 'Failed to update task!');
    } finally {
      notifyListeners();
    }
  }
}

class _ResultHolder {
  bool hasError;
  String message;

  _ResultHolder(this.hasError, this.message);
}
