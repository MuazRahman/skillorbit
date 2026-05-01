import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/admin_controller.dart';
import '../../services/firestore_course_service.dart';
import '../../widgets/course_icon_widget.dart';
import 'manage_modules_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  AdminDashboardScreen({super.key});

  final adminController = Get.put(AdminController());
  final courseService = FirestoreCourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            onPressed: () => _showCourseForm(context),
            tooltip: 'Add New Course',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await courseService.getAllCourses().first;
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: courseService.getAllCourses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('No courses found. Add one to get started.')),
                ],
              );
            }

            final courses = snapshot.data!.docs;

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final courseDoc = courses[index];
                final data = courseDoc.data() as Map<String, dynamic>;
                final courseId = courseDoc.id;

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    onTap: () => Get.to(() => ManageModulesScreen(
                      courseId: courseId,
                      courseName: data['name'] ?? 'Unknown',
                    )),
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Course icon preview
                          CourseIconWidget(
                            iconPath: data['icon'] ?? '',
                            size: 60,
                            iconSize: 30,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['name'] ?? 'Untitled',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  data['description'] ?? 'No description',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showCourseForm(context, id: courseId, currentData: data);
                              } else if (value == 'delete') {
                                _confirmDelete(context, courseId);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text('Edit')),
                              const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: Colors.red))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showCourseForm(BuildContext context, {String? id, Map<String, dynamic>? currentData}) {
    final nameController = TextEditingController(text: currentData?['name']);
    final descController = TextEditingController(text: currentData?['description']);
    final iconController = TextEditingController(text: currentData?['icon']);
    final imgController = TextEditingController(text: currentData?['imageUrl']);

    // ValueNotifier to show a live preview of the icon URL
    final iconPreview = ValueNotifier<String>(currentData?['icon'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id == null ? 'Add New Course' : 'Edit Course',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Icon URL field with live preview
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Live preview
                  ValueListenableBuilder<String>(
                    valueListenable: iconPreview,
                    builder: (context, url, _) {
                      return CourseIconWidget(
                        iconPath: url,
                        size: 56,
                        iconSize: 28,
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  // Text field
                  Expanded(
                    child: TextField(
                      controller: iconController,
                      decoration: const InputDecoration(
                        labelText: 'Course Icon URL (optional)',
                        hintText: 'Paste an image URL or leave empty',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        iconPreview.value = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Leave empty to use the default icon',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),

              const SizedBox(height: 16),
              TextField(
                controller: imgController,
                decoration: const InputDecoration(
                  labelText: 'Banner Image URL (optional)',
                  hintText: 'Paste a banner image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (id == null) {
                      adminController.createCourse(
                        name: nameController.text,
                        description: descController.text,
                        icon: iconController.text.trim(),
                        imageUrl: imgController.text.trim(),
                      );
                    } else {
                      adminController.updateCourse(id, {
                        'name': nameController.text,
                        'description': descController.text,
                        'icon': iconController.text.trim(),
                        'imageUrl': imgController.text.trim(),
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text(id == null ? 'Create Course' : 'Update Course'),
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
        title: const Text('Delete Course?'),
        content: const Text('This will remove the course metadata. Modules and topics are not automatically deleted.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              adminController.deleteCourse(id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
