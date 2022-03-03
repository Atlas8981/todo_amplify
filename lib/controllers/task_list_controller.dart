import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListController extends GetxController {
  TabController? tabController;

  TaskListController();

  TickerProvider? tickerProvider;

  final RxList<String> taskList = [
    "Buy List",
    "ជំនាញ",
    "កម្រិតសញ្ញាបត្រ",
    "ភេទ",
    "Kaleng Os Luy",
    "ឥស្សរិយយស្ស",
  ].obs;

  void addNewList(String newList, TickerProvider tickerProvider) {
    taskList.add(newList);
    tabController = TabController(
      length: getTabs().length,
      vsync: tickerProvider,
    );
    update();
  }

  List<Widget> getTabs() {
    final List<Widget> listOfTabs = [];
    final List<String> lists = taskList;
    for (String e in lists) {
      listOfTabs.add(
        Tab(text: e),
      );
    }
    listOfTabs.add(
      InkWell(
        onTap: () {
          addNewList("newList", tickerProvider!);
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
