enum TaskPriority { high, medium, low }

class Task {
  final String id;
  final String projectId;
  final String title;
  final TaskPriority priority;
  final String status;

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    required this.priority,
    required this.status,
  });
}
