import 'package:flutter/material.dart';
import 'package:nytbooks/core/enums/view_states.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';

import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/ui/base_view.dart';
import 'package:nytbooks/ui/commons/error_widget.dart';
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
              key: const Key('add_task_button'),
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
            _showSnacks(model, context);

            switch (model.viewState) {
              case ViewState.busy:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ViewState.error:
                return ErrorMessage(
                    message: 'Something went wrong while fetching your tasks.',
                    buttonTitle: 'Retry',
                    onTap: () {
                      model.fetchTasks();
                    });

              case ViewState.idle:
                return _buildIdleState(model);
            }
          },
        ));
  }

  void _showSnacks(TaskViewModel model, BuildContext context) {
    if (model.resultHolder != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(model.resultHolder!.message),
          backgroundColor:
              model.resultHolder!.hasError ? Colors.red : Colors.green,
        ));
        model.clearResultHolder();
      });
    }
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
  final Task task;
  const _Task(this.task);

  void _delete() {
    serviceLocator<TaskViewModel>().deleteTask(task);
  }

  void _toggleComplete() {
    task.toggleComplete();
    serviceLocator<TaskViewModel>().updateTask(task);
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
        key: Key('check_box_icon_${task.id}'),
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
