import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final service = TaskService();
  List<Task> tasks = [];
  @override
  void initState() {
    super.initState();

    final task = Task(
      id: '1',
      title: 'Estudar Flutter',
      description: 'Criar app',
      status: 'pending',
      createdAt: DateTime.now(),
    );

    service.addTask(task);
    tasks = service.getTasks();
  }
  void deleteTask(int index) {
  setState(() {
  tasks.removeAt(index);
    });
    }

  void toggleTaskStatus(int index) {
  final oldTask = tasks[index];

  final updatedTask = Task(
    id: oldTask.id,
    title: oldTask.title,
    description: oldTask.description,
    status: oldTask.status == 'done' ? 'pending' : 'done',
    createdAt: oldTask.createdAt,
  );

  setState(() {
    tasks[index] = updatedTask;
  });
}

  void addTask() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    void toggleTaskStatus(int index) {
  final oldTask = tasks[index];

  final updatedTask = Task(
    id: oldTask.id,
    title: oldTask.title,
    description: oldTask.description,
    status: oldTask.status == 'done' ? 'pending' : 'done',
    createdAt: oldTask.createdAt,
  );

  setState(() {
    tasks[index] = updatedTask;
  });
}

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova Tarefa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty) return;

                final newTask = Task(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  status: 'pending',
                  createdAt: DateTime.now(),
                );

                setState(() {
                  service.addTask(newTask);
                  tasks = service.getTasks();
                });

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tarefas diárias'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
        final task = tasks[index];

          return ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        Icon(
        task.status == 'done' ? Icons.check : Icons.close,
        ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => deleteTask(index),
      ),
      ],
      ),
      onTap: () {
      toggleTaskStatus(index);
      },
      );
      },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}