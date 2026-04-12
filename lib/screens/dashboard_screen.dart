import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nav_complexit_ystudy/models/project.dart';

class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class ProjectsListScreen extends StatelessWidget {
  final List<Project> projects = [
    Project(id: '1', name: 'Mobile App Refactor', progress: 0.65),
    Project(id: '2', name: 'Legacy System Sync', progress: 0.30),
    Project(id: '3', name: 'Q1 Security Audit', progress: 0.85),
    Project(id: '4', name: 'Client Onboarding', progress: 0.10),
  ];

  ProjectsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Projects')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                project.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: project.progress,
                    backgroundColor: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 4),
                  Text('${(project.progress * 100).toInt()}% complete'),
                ],
              ),
              onTap: () {}, // Empty callback
            ),
          );
        },
      ),
    );
  }
}
