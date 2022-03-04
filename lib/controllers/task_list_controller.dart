import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/models/ModelProvider.dart';
import 'package:todo_amplify/views/add_type_of_task_page.dart';

class TaskListController extends GetxController {
  TabController? tabController;

  TickerProvider? tickerProvider;

  final List<TypeOfTask> taskList = [];

  void addNewLists(List<TypeOfTask> newLists, TickerProvider tickerProvider) {
    taskList.clear();
    taskList.addAll(newLists);
    tabController = TabController(
      length: getTabs().length,
      vsync: tickerProvider,
    );
    update();
  }

  void addNewList(TypeOfTask newList, TickerProvider? tickerProvider) {
    taskList.add(newList);
    tabController = TabController(
      length: getTabs().length,
      vsync: tickerProvider ?? this.tickerProvider!,
    );
    update();
  }

  List<Widget> getTabs() {
    final List<Widget> listOfTabs = [];
    final List<String> lists = taskList
        .map(
          (element) => element.name ?? "",
        )
        .toList();
    for (String e in lists) {
      listOfTabs.add(
        Tab(text: e),
      );
    }
    listOfTabs.add(
      InkWell(
        onTap: () {
          Get.to(
            () => AddTypeOfTaskPage(),
            fullscreenDialog: true,
          );
        },
        child: Tab(
          child: Row(
            children: [
              Icon(Icons.add),
              Text("Add New List"),
            ],
          ),
        ),
      ),
    );
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
}
