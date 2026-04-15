import '../models/task.dart';

class TaskService {
  final List<Task> _tasks = [];

  // Criar tarefa
  void addTask(Task task) {
    _tasks.add(task);
  }

  // Listar tarefas
  List<Task> getTasks() {
    return _tasks;
  }
}