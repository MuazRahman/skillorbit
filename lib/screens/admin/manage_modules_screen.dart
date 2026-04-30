import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/admin_controller.dart';
import '../../services/firestore_course_service.dart';
import 'manage_topics_screen.dart';

class ManageModulesScreen extends StatelessWidget {
  final String courseId;
  final String courseName;

  ManageModulesScreen({super.key, required this.courseId, required this.courseName});

  final adminController = Get.find<AdminController>();
  final courseService = FirestoreCourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules: $courseName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () => _showModuleForm(context),
            tooltip: 'Add Module',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: courseService.getCourseModules(courseId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final modules = snapshot.data?.docs ?? [];
          print('ManageModulesScreen: Received ${modules.length} modules for courseId: $courseId');
          if (modules.isNotEmpty) {
            print('First module courseId: ${modules.first.get('courseId')}');
          }

          if (modules.isEmpty) {
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('modules').get(),
              builder: (context, debugSnapshot) {
                final allIds = debugSnapshot.data?.docs.map((d) => d.id).toList() ?? [];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text('No modules found for this course.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Looking for courseId: "$courseId"', style: const TextStyle(color: Colors.blue)),
                        const SizedBox(height: 24),
                        const Text('Debug: All IDs in "modules" collection:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(height: 8),
                        if (allIds.isEmpty)
                          const Text('The "modules" collection is completely empty!', style: TextStyle(color: Colors.red))
                        else
                          Column(
                            children: debugSnapshot.data!.docs.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              return Text('DocID: ${doc.id} -> courseId field: "${data['courseId']}"', style: const TextStyle(fontSize: 10));
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                );
              }
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final moduleDoc = modules[index];
              final data = moduleDoc.data() as Map<String, dynamic>;
              final moduleId = moduleDoc.id;

              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${data['order'] ?? 0}')),
                  title: Text(data['name'] ?? 'Untitled Module', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Tap to manage topics'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => _showModuleForm(context, id: moduleId, currentData: data),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                        onPressed: () => _confirmDelete(context, moduleId),
                      ),
                    ],
                  ),
                  onTap: () => Get.to(() => ManageTopicsScreen(
                    moduleId: moduleId,
                    moduleName: data['name'] ?? 'Unknown',
                    courseName: courseName,
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showModuleForm(BuildContext context, {String? id, Map<String, dynamic>? currentData}) {
    final nameController = TextEditingController(text: currentData?['name']);
    final orderController = TextEditingController(text: (currentData?['order'] ?? 0).toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Module' : 'Edit Module'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Module Name')),
            TextField(controller: orderController, decoration: const InputDecoration(labelText: 'Display Order'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (id == null) {
                adminController.addModule(
                  courseId: courseId,
                  name: nameController.text,
                  order: int.tryParse(orderController.text) ?? 0,
                );
              } else {
                // Update module logic could be added to AdminController
                courseService.updateModule(id, {
                  'name': nameController.text,
                  'order': int.tryParse(orderController.text) ?? 0,
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Module?'),
        content: const Text('This will remove the module and its link to course.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              courseService.deleteModule(id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
