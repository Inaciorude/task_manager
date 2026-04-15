class Task {
  final String id;
  final String title;
  final String description;
  final String status; // pending, in_progress, done
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  // Converter para Map (salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Criar a partir de Map (ler do banco)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}