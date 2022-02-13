import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/core/services/firebase_service.dart';
import 'package:nytbooks/view_models/base_model.dart';

class TaskViewModel extends BaseModel {
  List<Task> tasks = [];

  List<Task> get completedTasks =>
      tasks.where((task) => task.isCompleted).toList();

  bool containsFirebaseCallErrors = false;
  String? errorMessage;

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

  Future addTask(Task task) async {
    String docId = await FirebaseService.shared.addTask(task);
    task.id = docId;

    tasks.add(task);
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    try {
      if (task.id != null) {
        await FirebaseService.shared.deleteTask(task.id!);
        tasks.removeWhere((element) => element.id == task.id);
      }
    } catch (error) {
      containsFirebaseCallErrors = true;
      errorMessage = 'Failed to delete task!';
    } finally {
      notifyListeners();
    }
  }

  Future updateTask(Task updatedTask) async {
    await FirebaseService.shared.editTask(updatedTask);
    tasks[tasks.indexWhere((element) => element.id == updatedTask.id)] =
        updatedTask;
    notifyListeners();
  }
}
