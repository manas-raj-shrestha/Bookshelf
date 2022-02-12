import 'package:flutter/material.dart';
import 'package:nytbooks/core/enums/view_states.dart';

import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/ui/base_view.dart';
import 'package:nytbooks/ui/task/task_screen.dart';
import 'package:nytbooks/view_models/task_view_model.dart';

class TasksPage extends StatelessWidget {
  final String title;
  final bool isCompletedPage;

  const TasksPage(
      {Key? key, required this.title, required this.isCompletedPage})
      : super(key: key);

  void addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TaskPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => addTask(context),
            )
          ],
        ),
        body: BaseView<TaskViewModel>(
          onModelReady: (TaskViewModel model) {
            model.fetchTasks();
          },
          builder: (context, model, child) {
            switch (model.viewState) {
              case ViewState.busy:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ViewState.error:
                return const Center(child: Text('Something went wrong'));

              case ViewState.idle:
                return _buildIdleState(model);
            }
          },
        ));
  }

  Widget _buildIdleState(TaskViewModel model) {
    var tasks = isCompletedPage ? model.completedTasks : model.tasks;
    return tasks.isEmpty
        ? const Center(
            child: Text('Add your first task'),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return _Task(
                tasks[index],
              );
            },
          );
  }
}

class _Task extends StatelessWidget {
  const _Task(this.task);

  final Task task;

  void _delete() {
    //TODO implement delete to firestore
  }

  void _toggleComplete() {
    //TODO implement toggle complete to firestore
  }

  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onPressed: _toggleComplete,
      ),
      title: Text(task.title ?? ''),
      subtitle: Text(task.description ?? ''),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
        ),
        onPressed: _delete,
      ),
      onTap: () => _view(context),
    );
  }
}
