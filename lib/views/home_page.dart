import 'package:animated_check/animated_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/controllers/task_list_controller.dart';
import 'package:todo_amplify/views/add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final taskListController = Get.put(TaskListController());

  List<Widget> appBarActions() {
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(CupertinoIcons.gear),
      )
    ];
  }

  Widget bottomAppBar() {
    return BottomAppBar(
      notchMargin: 8,
      elevation: 5,
      shape: CircularNotchedRectangle(),
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 30.0,
              icon: Icon(Icons.list),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar(context, innerBoxIsScrolled, tabs, tabController) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverSafeArea(
        top: false,
        sliver: SliverAppBar(
          title: const Text('Tasks'),
          floating: true,
          pinned: true,
          snap: false,
          primary: true,
          stretch: true,
          forceElevated: innerBoxIsScrolled,
          actions: appBarActions(),

          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: FlutterLogo(),
          ),
          bottom: TabBar(
            controller: tabController,
            tabs: tabs,
            isScrollable: true,
            indicatorWeight: 3,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddPage());
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: bottomAppBar(),
      body: GetBuilder<TaskListController>(
        builder: (controller) {
          final tabs = taskListController.getTabs();
          final tabController = taskListController.getTabController(this);
          return NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                customAppBar(
                  context,
                  innerBoxIsScrolled,
                  tabs,
                  tabController,
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 100,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "Something $index",
                      ),
                      onTap: () {},
                    ),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  ExpansionTile(
                    title: Text("Complete (11)"),
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            "Something $index",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
