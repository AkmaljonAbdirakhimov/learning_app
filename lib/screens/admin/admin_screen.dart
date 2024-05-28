import 'package:flutter/material.dart';
import 'package:learning_app/screens/admin/course/manage_courses_screen.dart.dart';
import 'package:learning_app/widgets/custom_drawer.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Screen'),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const ManageCoursesScreen(),
                ),
              );
            },
            leading: const Icon(Icons.category),
            title: const Text("Manage Courses"),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
