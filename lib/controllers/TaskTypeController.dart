import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/models/TaskType.dart';
import 'package:todo_amplify/services/TaskService.dart';

class TaskTypeController extends GetxController {
  final List<TaskType> taskTypes = [];

  void setNewLists(List<TaskType> newTaskTypes) {
    taskTypes.clear();
    taskTypes.addAll(newTaskTypes);
    update();
  }

  void setNewList(TaskType newTaskTypes) {
    taskTypes.add(newTaskTypes);
    update();
  }

  List<Widget> getTabs() {
    final List<Widget> listOfTabs = [];
    final List<String> lists = taskTypes
        .map(
          (element) => element.name ?? "",
        )
        .toList();
    for (String e in lists) {
      listOfTabs.add(
        Tab(
          text: e,
        ),
      );
    }
    return listOfTabs;
  }

  // TaskType getSelectedTypeOfList() {
  //   return taskTypes[tabController?.index ?? 0];
  // }
}
