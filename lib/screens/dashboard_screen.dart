import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/models/project.dart';
import 'package:nav_complexit_ystudy/navigation/router_delegate.dart';
import 'package:nav_complexit_ystudy/screens/profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  final List<Project> projects = [
    Project(id: '1', name: 'Mobile App Refactor', progress: 0.65),
    Project(id: '2', name: 'Legacy System Sync', progress: 0.30),
    Project(id: '3', name: 'Q1 Security Audit', progress: 0.85),
    Project(id: '4', name: 'Client Onboarding', progress: 0.10),
  ];

  DashboardScreen({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        pages: [
          if (selectedIndex == 0)
            MaterialPage(
              key: const ValueKey('ProjectsList'),
              child: _buildProjectsList(),
            ),
          if (selectedIndex == 1)
            const MaterialPage(
              key: ValueKey('ProfileScreen'),
              child: ProfileScreen(),
            ),
        ],
        // ignore: deprecated_member_use
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTabSelected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
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
              onTap: () {
                final delegate = Router.of(context).routerDelegate as AppRouterDelegate;
                delegate.selectProject(project.id);
              },
            ),
          );
        },
      ),
    );
  }
}
