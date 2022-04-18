import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/controllers/task_type_controller.dart';
import 'package:todo_amplify/models/Task.dart';
import 'package:todo_amplify/models/TaskType.dart';

class TaskService {
  final db = FirebaseFirestore.instance;
  static const String taskTypeCollection = "taskTypes";
  static const String taskCollection = "tasks";

  final taskTypeController = Get.find<TaskTypeController>();

  Future<bool> addTaskTypes(String taskTypeName) async {
    final id = db.collection(taskTypeCollection).doc().id;
    final TaskType taskType = TaskType(
      id: id,
      name: taskTypeName,
      tasks: [],
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
    try {
      await db.collection(taskTypeCollection).doc(id).set(taskType.toJson());
      taskTypeController.addNewList(taskType, null);
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> addTasks(Task task, String taskTypeId) async {
    final id = db.collection(taskTypeCollection).doc().id;
    final tempTask = Task(
      id: id,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );
    try {
      await db.collection(taskCollection).doc(id).set(task.toJson());
      // taskTypeController.addNewList(taskType, null);
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<List<TaskType>?> getAllTaskTypes() async {
    try {
      await db.collection(taskTypeCollection).get();
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<List<Task>?> getAllTasks() async {
    try {
      await db.collection(taskCollection).get();
      return [];
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
