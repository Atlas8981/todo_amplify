import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_amplify/models/SubTask.dart';
import 'package:todo_amplify/models/Task.dart';
import 'package:todo_amplify/models/TaskType.dart';

class TaskService {
  final db = FirebaseFirestore.instance;
  static const String taskTypeCollection = "taskTypes";
  static const String taskCollection = "tasks";

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

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return false;
  }

  Future<bool> addTasks(Task task, String taskTypeId) async {
    final id = db.collection(taskTypeCollection).doc().id;
    final tempTask = Task(
      id: id,
      name: task.name,
      deadline: task.deadline,
      description: task.description,
      isComplete: false,
      subTasks: [] as List<SubTask>,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    try {
      final docSnapshot =
          await db.collection(taskTypeCollection).doc(taskTypeId).get();
      if (docSnapshot.exists) {
        final taskType = TaskType.fromJson(docSnapshot.data()!);
        taskType.tasks ??= [];
        taskType.tasks!.add(tempTask);
        db
            .collection(taskTypeCollection)
            .doc(taskType.id)
            .set(taskType.toJson());
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return false;
  }

  Future<List<TaskType>?> getAllTaskTypes() async {
    try {
      await db.collection(taskTypeCollection).get();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  Future<List<Task>?> getAllTasks(TaskType taskType) async {
    try {
      // await db.collection(taskTypeCollection).doc(taskType.id).get();
      return [];
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
