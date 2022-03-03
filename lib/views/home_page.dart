import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/controllers/task_list_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final taskListController = Get.put(TaskListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<TaskListController>(
        builder: (controller) {
          final tabs = taskListController.getTabs();
          final tabController = taskListController.getTabController(this);
          return DefaultTabController(
            length: tabs.length,
            child: NestedScrollView(
              floatHeaderSlivers: false,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverSafeArea(
                      top: false,
                      sliver: SliverAppBar(
                        title: const Text('ព័ត៌មានផ្ទាល់ខ្លួន'),
                        floating: true,
                        pinned: true,
                        snap: false,
                        primary: true,
                        stretch: true,
                        forceElevated: innerBoxIsScrolled,
                        bottom: TabBar(
                          controller: tabController,
                          tabs: tabs,
                          isScrollable: true,
                          indicatorWeight: 3,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    "Something",
                  ),
                  onTap: () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget staticWidget(tabController, tabs) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task",
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: tabs,
          isScrollable: true,
          indicatorWeight: 3,
        ),
      ),
      body: DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                "Something",
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}