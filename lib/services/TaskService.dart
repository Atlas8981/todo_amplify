import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_amplify/models/Task.dart';
import 'package:todo_amplify/models/TaskType.dart';

class TaskService {
  final db = FirebaseFirestore.instance;
  static const String taskTypeCollection = "taskTypes";
  static const String taskCollection = "tasks";

  Future<List<TaskType>?> addAllTaskTypes(TaskType taskType) async {
    try {
      await db.collection(taskTypeCollection)
          .add(taskType.toJson());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
  Future<List<TaskType>?> addAllTasks(Task task) async {
    try {
      await db.collection(taskCollection)
          .add(task.toJson());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<TaskType>?> getAllTaskTypes() async {
    try {
      await db.collection(taskTypeCollection)
          .get();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<Task>?> getAllTasks() async {
    try {
      await db.collection(taskCollection)
          .get();
      return [];
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
