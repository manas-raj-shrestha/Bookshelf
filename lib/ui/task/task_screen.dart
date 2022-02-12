import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nytbooks/core/helper/dependency_injection.dart';
import 'package:nytbooks/core/models/task.dart';
import 'package:nytbooks/view_models/task_view_model.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit Task'),
      ),
      body: _TaskForm(task: task),
    );
  }
}

class _TaskForm extends StatefulWidget {
  final Task? task;

  _TaskForm({this.task});

  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  Task? task;
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  __TaskFormState(this.task);

  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task?.title ?? '');
      _descriptionController =
          TextEditingController(text: task?.description ?? '');
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    task!.title = _titleController!.text;
    task!.description = _descriptionController!.text;

    serviceLocator<TaskViewModel>().addTask(task!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(_padding),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: _padding),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              minLines: 5,
              maxLines: 10,
            ),
            SizedBox(height: _padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed ?'),
                CupertinoSwitch(
                  value: task?.isCompleted ?? false,
                  onChanged: (_) {
                    setState(() {
                      task?.toggleComplete();
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _save(context),
              child: Container(
                width: double.infinity,
                child: Center(child: Text((task!.isNew) ? 'Create' : 'Update')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
