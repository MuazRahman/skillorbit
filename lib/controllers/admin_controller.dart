import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/firestore_course_service.dart';

class AdminController extends GetxController {
  final FirestoreCourseService _service = FirestoreCourseService();
  
  var isLoading = false.obs;

  // Courses
  Future<void> createCourse({
    required String name,
    required String description,
    required String icon,
    required String imageUrl,
  }) async {
    try {
      isLoading.value = true;
      await _service.addCourse({
        'name': name,
        'description': description,
        'icon': icon,
        'imageUrl': imageUrl,
        'topicNames': [], // Metadata for simple views
        'createdAt': DateTime.now().toIso8601String(),
      });
      Get.snackbar('Success', 'Course created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCourse(String id, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      await _service.updateCourse(id, data);
      Get.snackbar('Success', 'Course updated');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      isLoading.value = true;
      await _service.deleteCourse(id);
      Get.snackbar('Success', 'Course deleted');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addModule({
    required String courseId,
    required String name,
    required int order,
  }) async {
    try {
      isLoading.value = true;
      final data = {
        'courseId': courseId,
        'name': name,
        'order': order,
      };
      print('AdminController: Sending to Firestore: $data');
      await _service.addModule(data);
      print('AdminController: Successfully added module "$name"');
      Get.snackbar('Success', 'Module added successfully');
    } catch (e) {
      print('AdminController ERROR adding module: $e');
      Get.snackbar('Error', 'Failed to add module: $e', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Topics
  Future<void> addTopic({
    required String moduleId,
    required String name,
    required String description,
    required String videoUrl,
    required String tutorialLink,
    required int order,
  }) async {
    try {
      isLoading.value = true;
      await _service.addTopic({
        'moduleId': moduleId,
        'name': name,
        'description': description,
        'videoUrl': videoUrl,
        'tutorialLink': tutorialLink,
        'order': order,
      });
      Get.snackbar('Success', 'Topic added');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Quizzes
  Future<void> addQuizQuestion({
    required String parentId,
    required String question,
    required List<String> options,
    required int correctOptionIndex,
    required int order,
  }) async {
    try {
      isLoading.value = true;
      await _service.addQuizQuestion({
        'parentId': parentId,
        'question': question,
        'options': options,
        'correctOptionIndex': correctOptionIndex,
        'order': order,
      });
      Get.snackbar('Success', 'Quiz question added');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
