import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/models/TaskType.dart';
import 'package:todo_amplify/services/TaskService.dart';

class TaskTypeController extends GetxController {



  TabController? tabController;

  TickerProvider? tickerProvider;

  final List<TaskType> taskTypes = [];


  void addNewLists(List<TaskType> newTaskTypes, TickerProvider? tickerProvider) {
    taskTypes.clear();
    taskTypes.addAll(newTaskTypes);
    tabController = TabController(
      length: getTabs().length,
      vsync: tickerProvider ?? this.tickerProvider!,
    );
    update();
  }

  void addNewList(TaskType newTaskTypes, TickerProvider? tickerProvider) {
    taskTypes.add(newTaskTypes);
    tabController = TabController(
      length: getTabs().length,
      vsync: tickerProvider ?? this.tickerProvider!,
    );
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

  TabController getTabController(TickerProvider tickerProvider) {
    tabController ??= TabController(
      length: getTabs().length,
      vsync: tickerProvider,
    );
    this.tickerProvider = tickerProvider;
    return tabController!;
  }

  TaskType getSelectedTypeOfList() {
    return taskTypes[tabController?.index ?? 0];
  }

}
