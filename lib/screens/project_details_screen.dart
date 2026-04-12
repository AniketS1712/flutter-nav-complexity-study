import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/models/task.dart';
import 'package:nav_complexit_ystudy/models/project.dart';
import 'package:nav_complexit_ystudy/navigation/routes.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;
  final List<Task> tasks = [
    Task(id: '1', projectId: '1', title: 'Update API Endpoints', priority: TaskPriority.high, status: 'In Progress'),
    Task(id: '2', projectId: '1', title: 'Fix Header Alignment', priority: TaskPriority.low, status: 'Done'),
    Task(id: '3', projectId: '1', title: 'Add Test Suites', priority: TaskPriority.medium, status: 'To Do'),
    Task(id: '4', projectId: '1', title: 'Documentation', priority: TaskPriority.medium, status: 'To Do'),
  ];

  ProjectDetailsScreen({super.key, required this.project});

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.orangeAccent;
      case TaskPriority.low:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(task.title),
              subtitle: Text('Status: ${task.status}'),
              trailing: Chip(
                label: Text(
                  task.priority.name.toUpperCase(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                backgroundColor: _getPriorityColor(task.priority),
                side: BorderSide.none,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.taskDetails,
                  arguments: task,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
