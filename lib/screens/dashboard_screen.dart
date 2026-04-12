import 'package:flutter/material.dart';
import 'package:nav_complexit_ystudy/models/project.dart';
import 'package:nav_complexit_ystudy/navigation/routes.dart';
import 'package:nav_complexit_ystudy/screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Project> projects = [
    Project(id: '1', name: 'Mobile App Refactor', progress: 0.65),
    Project(id: '2', name: 'Legacy System Sync', progress: 0.30),
    Project(id: '3', name: 'Q1 Security Audit', progress: 0.85),
    Project(id: '4', name: 'Client Onboarding', progress: 0.10),
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildDashboardContent(),
      const ProfileScreen(),
      const Scaffold(body: Center(child: Text('Settings Placeholder'))),
    ];
  }

  Widget _buildDashboardContent() {
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
                Navigator.pushNamed(
                  context,
                  AppRoutes.projectDetails,
                  arguments: project,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
