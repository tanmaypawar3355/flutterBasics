import 'package:flutter/material.dart';
import 'package:practice_flutter_application_21/models/task.dart';
import 'package:practice_flutter_application_21/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _SqfLiteState();
}

class _SqfLiteState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _tasksList(), floatingActionButton: _addTaskButton());
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _task = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Title",
                  ),
                ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    if (_task == null || _task == "") return;
                    _databaseService.addTask(_task!);
                    setState(() {
                      _task = null;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Add", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
      future: _databaseService.getTasks(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Task task = snapshot.data![index];
            return ListTile(
              onLongPress: () {
                _databaseService.deleteTask(task.id);
                setState(() {
                  
                });
              },
              title: Text(task.content),
              trailing: Checkbox(
                value: task.status == 1,
                onChanged: (value) {
                  setState(() {
                    _databaseService.updateTaskStatus(
                      task.id,
                      value == true ? 1 : 0,
                    );
                    setState(() {});
                  });
                },
              ),
            );
          },
        );
      },
    );
  }
}
