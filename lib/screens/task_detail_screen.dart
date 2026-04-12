import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    super.key, 
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                task.status,
                style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This is a mock description for the task. It includes details about the requirements, expected outcomes, and any dependencies. In a real app, this would be fetched from a database and might contain markdown or rich text content. The goal of this screen is to show the full scope of a single task item within TaskFlow.',
              style: TextStyle(height: 1.5, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
