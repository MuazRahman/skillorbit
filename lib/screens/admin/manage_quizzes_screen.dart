import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/admin_controller.dart';
import '../../services/firestore_course_service.dart';

class ManageQuizzesScreen extends StatelessWidget {
  final String parentId;
  final String parentName;

  ManageQuizzesScreen(
      {super.key, required this.parentId, required this.parentName});

  final adminController = Get.find<AdminController>();
  final courseService = FirestoreCourseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes: $parentName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task),
            onPressed: () => _showQuestionForm(context),
            tooltip: 'Add Question',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: courseService.getQuizQuestions(parentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No quiz questions found for this topic.'));
          }

          final questions = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final questionDoc = questions[index];
              final data = questionDoc.data() as Map<String, dynamic>;
              final questionId = questionDoc.id;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(child: Text('${data['order'] ?? 0}')),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              data['question'] ?? 'No question text',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () => _showQuestionForm(context,
                                id: questionId, currentData: data),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                size: 20, color: Colors.red),
                            onPressed: () =>
                                _confirmDelete(context, questionId),
                          ),
                        ],
                      ),
                      const Divider(),
                      ...(data['options'] as List<dynamic>)
                          .asMap()
                          .entries
                          .map((entry) {
                        final int idx = entry.key;
                        final String option = entry.value.toString();
                        final bool isCorrect =
                            idx == (data['correctOptionIndex'] ?? -1);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                isCorrect
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: isCorrect ? Colors.green : Colors.grey,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    color:
                                        isCorrect ? Colors.green : Colors.black,
                                    fontWeight: isCorrect
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showQuestionForm(BuildContext context,
      {String? id, Map<String, dynamic>? currentData}) {
    final questionController =
        TextEditingController(text: currentData?['question']);
    final options = (currentData?['options'] as List<dynamic>?)
            ?.map((e) => TextEditingController(text: e.toString()))
            .toList() ??
        [
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
          TextEditingController()
        ];
    int correctIndex = currentData?['correctOptionIndex'] ?? 0;
    final orderController =
        TextEditingController(text: (currentData?['order'] ?? 0).toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 24,
              right: 24,
              top: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(id == null ? 'Add Question' : 'Edit Question',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                    controller: questionController,
                    decoration:
                        const InputDecoration(labelText: 'Question Text'),
                    maxLines: 2),
                const SizedBox(height: 16),
                const Text('Options (Select the correct one)',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ...options.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: entry.key,
                          groupValue: correctIndex,
                          onChanged: (val) =>
                              setModalState(() => correctIndex = val!),
                        ),
                        Expanded(
                            child: TextField(
                                controller: entry.value,
                                decoration: InputDecoration(
                                    labelText: 'Option ${entry.key + 1}'))),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),
                TextField(
                    controller: orderController,
                    decoration:
                        const InputDecoration(labelText: 'Display Order'),
                    keyboardType: TextInputType.number),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final optionsText = options.map((e) => e.text).toList();
                      if (id == null) {
                        adminController.addQuizQuestion(
                          parentId: parentId,
                          question: questionController.text,
                          options: optionsText,
                          correctOptionIndex: correctIndex,
                          order: int.tryParse(orderController.text) ?? 0,
                        );
                      } else {
                        courseService.updateQuizQuestion(id, {
                          'parentId': parentId,
                          'question': questionController.text,
                          'options': optionsText,
                          'correctOptionIndex': correctIndex,
                          'order': int.tryParse(orderController.text) ?? 0,
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Save Question'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Question?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                courseService.deleteQuizQuestion(id);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
