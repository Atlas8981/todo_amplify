import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/components/custom_tab_bar_indicator.dart';
import 'package:todo_amplify/controllers/task_list_controller.dart';
import 'package:todo_amplify/models/ModelProvider.dart';
import 'package:todo_amplify/views/add_task_page.dart';
import 'package:todo_amplify/views/edit_task_page.dart';

import '../amplifyconfiguration.dart';
import 'add_type_of_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final AmplifyDataStore _dataStorePlugin = AmplifyDataStore(
    modelProvider: ModelProvider.instance,
  );

  late StreamSubscription<QuerySnapshot<TypeOfTask>> _subscription;

  final taskListController = Get.put(TaskListController());

  List<Widget> appBarActions() {
    return [
      IconButton(
        onPressed: () async {
          // final List<Task> tasks = await Amplify.DataStore.query(Task.classType,
          //     where: Task.TYPEOFTASKID.eq(typeOfTasks[0].id));
          // print(tasks);
          // print(typeOfTasks[0]);
        },
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
              iconSize: 28.0,
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 28.0,
              icon: Icon(Icons.more_vert_rounded),
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
          bottom: PreferredSize(
            preferredSize: Size(
              double.maxFinite,
              kToolbarHeight,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TabBar(
                    controller: tabController,
                    tabs: tabs,
                    isScrollable: true,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: CustomUnderlineBarIndicator(
                      color: Colors.blue,
                    ),
                  ),
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
                ],
              ),
            ),
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
          Get.to(() => AddTaskPage());
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: bottomAppBar(),
      body: GetBuilder<TaskListController>(
        builder: (controller) {
          final tabs = taskListController.getTabs();
          final tabController = taskListController.getTabController(this);
          final typeOfTask = taskListController.taskList;
          return DefaultTabController(
            length: typeOfTask.length,
            child: NestedScrollView(
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
              body: TabBarView(
                controller: tabController,
                children: typeOfTask.map(
                  (e) {
                    return taskBodyView(e);
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget taskBodyView(TypeOfTask typeOfTask) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List<Task>?>(
            future: Amplify.DataStore.query(
              Task.classType,
              where: Task.TYPEOFTASKID.eq(typeOfTask.id),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final tasks = snapshot.data;
              if (tasks == null) {
                return const Center(
                  child: Text("No Task"),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    tasks[index].name ?? "",
                  ),
                  onTap: () {
                    Get.to(() => EditTaskPage(task: tasks[index]));
                  },
                  onLongPress: () {},
                ),
              );
            },
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
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _configureAmplify();

    _subscription = Amplify.DataStore.observeQuery(TypeOfTask.classType)
        .listen((QuerySnapshot<TypeOfTask> snapshot) {
      taskListController.addNewLists(snapshot.items, this);
    });
  }

  Future<void> _configureAmplify() async {
    try {
      // add Amplify plugins
      await Amplify.addPlugins([_dataStorePlugin]);
      await Amplify.addPlugin(
        AmplifyAPI(modelProvider: ModelProvider.instance),
      );
      if (!Amplify.isConfigured) {
        await Amplify.configure(amplifyconfig);
      }
    } catch (e) {
      print('An error occurred while configuring Amplify: $e');
    }
  }

// Future<void> getAllItem() async {
//   try {
//     // items = await Amplify.DataStore.query(Item.classType);
//     Amplify.DataStore.observeQuery(Item.classType).listen((event) {
//       for (var element in event.items) {
//         print(element.name);
//       }
//       items = event.items;
//     });
//   } catch (e) {
//     print('An error occurred while saving: $e');
//   }
// }
//
// Future<void> updateItem() async {
//   Item updatedItem = items[items.length - 1].copyWith(name: "Soemthing new");
//
//   try {
//     await Amplify.DataStore.save(updatedItem);
//   } catch (e) {
//     print('An error occurred while saving Todo: $e');
//   }
// }
//
// Future<void> syncData() async {
//   await Amplify.DataStore.start();
// }
}
