import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/core/services/firebase_service.dart';
import 'package:nytbooks/view_models/base_model.dart';

class TaskViewModel extends BaseModel {
  List<Task> tasks = [];

  List<Task> get completedTasks =>
      tasks.where((task) => task.isCompleted).toList();

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
}
