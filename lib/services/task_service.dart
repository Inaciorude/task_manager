import '../models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Criar tarefa
  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toMap());
}
  
  // Listar tarefas
Future<List<Task>> getTasks() async {
  final snapshot = await _firestore.collection('tasks').get();

  return snapshot.docs.map((doc) {
  return Task.fromMap(doc.data());
  }).toList();

}
}
