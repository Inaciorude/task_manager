import '../models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Criar tarefa
  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toMap());
}
  
  // Listar tarefas
  List<Task> getTasks() {
    return [];
  }
}
