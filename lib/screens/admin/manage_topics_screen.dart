import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/admin_controller.dart';
import '../../services/firestore_course_service.dart';
import 'manage_quizzes_screen.dart';

class ManageTopicsScreen extends StatelessWidget {
  final String moduleId;
  final String moduleName;
  final String courseName;

  ManageTopicsScreen({super.key, required this.moduleId, required this.moduleName, required this.courseName});

  final adminController = Get.find<AdminController>();
  final courseService = FirestoreCourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topics: $moduleName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task),
            onPressed: () => _showTopicForm(context),
            tooltip: 'Add Topic',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: courseService.getModuleTopics(moduleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No topics found in this module.'));
          }

          final topics = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topicDoc = topics[index];
              final data = topicDoc.data() as Map<String, dynamic>;
              final topicId = topicDoc.id;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  leading: CircleAvatar(child: Text('${data['order'] ?? 0}')),
                  title: Text(data['name'] ?? 'Untitled Topic', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(data['description'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Video:', data['videoUrl'] ?? 'None'),
                          _buildDetailRow('Doc:', data['tutorialLink'] ?? 'None'),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                icon: const Icon(Icons.quiz),
                                label: const Text('Manage Quiz'),
                                onPressed: () {
                                  Get.to(() => ManageQuizzesScreen(
                                    parentId: topicId,
                                    parentName: data['name'] ?? 'Unknown Topic',
                                  ));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showTopicForm(context, id: topicId, currentData: data),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _confirmDelete(context, topicId),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, color: Colors.blue), maxLines: 1, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  void _showTopicForm(BuildContext context, {String? id, Map<String, dynamic>? currentData}) {
    final nameController = TextEditingController(text: currentData?['name']);
    final descController = TextEditingController(text: currentData?['description']);
    final videoController = TextEditingController(text: currentData?['videoUrl']);
    final docController = TextEditingController(text: currentData?['tutorialLink']);
    final orderController = TextEditingController(text: (currentData?['order'] ?? 0).toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(id == null ? 'Add Topic' : 'Edit Topic', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Topic Name')),
              const SizedBox(height: 12),
              TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
              const SizedBox(height: 12),
              TextField(controller: videoController, decoration: const InputDecoration(labelText: 'YouTube Video URL')),
              const SizedBox(height: 12),
              TextField(controller: docController, decoration: const InputDecoration(labelText: 'Document/Tutorial Link')),
              const SizedBox(height: 12),
              TextField(controller: orderController, decoration: const InputDecoration(labelText: 'Order'), keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final data = {
                      'moduleId': moduleId,
                      'name': nameController.text,
                      'description': descController.text,
                      'videoUrl': videoController.text,
                      'tutorialLink': docController.text,
                      'order': int.tryParse(orderController.text) ?? 0,
                    };
                    if (id == null) {
                      adminController.addTopic(
                        moduleId: moduleId,
                        name: data['name'] as String,
                        description: data['description'] as String,
                        videoUrl: data['videoUrl'] as String,
                        tutorialLink: data['tutorialLink'] as String,
                        order: data['order'] as int,
                      );
                    } else {
                      courseService.updateTopic(id, data);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Save Topic'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Topic?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () { courseService.deleteTopic(id); Navigator.pop(context); }, child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
