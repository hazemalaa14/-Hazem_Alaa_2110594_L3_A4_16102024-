import 'package:flutter/material.dart';

class Task {
  String title;
  bool completed;
  Task({required this.title, this.completed = false});
}

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> tasks = [];
  final TextEditingController taskControl = TextEditingController();

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('TODO App'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskControl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'enter a task',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addTask,
            child: Text('Add task'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: tasks[index].completed,
                        onChanged: (_) => taskCompleted(index),
                      ),
                      title: Text(
                        tasks[index].title,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addTask() {
    setState(() {
      if (taskControl.text.isNotEmpty) {
        tasks.add(Task(title: taskControl.text));
        taskControl.clear();
      }
    });
  }

  void taskCompleted(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }
}
