import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/components/CustomTabBarIndicator.dart';
import 'package:todo_amplify/controllers/TaskTypeController.dart';
import 'package:todo_amplify/models/Task.dart';
import 'package:todo_amplify/models/TaskType.dart';
import 'package:todo_amplify/services/TaskService.dart';
import 'package:todo_amplify/utils/constant.dart';
import 'package:todo_amplify/views/task/add_task_page.dart';
import 'package:todo_amplify/views/task/edit_task_page.dart';
import 'package:todo_amplify/views/task_type/rename_task_type.dart';

import 'task_type/add_task_type_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final taskListController = Get.put(TaskTypeController());
  TabController? tabController;
  final taskService = TaskService();

  List<Widget> appBarActions(TabController tabController) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(CupertinoIcons.gear),
      )
    ];
  }

  Widget bottomAppBar() {
    final listOfTask = taskListController.taskTypes;
    return BottomAppBar(
      notchMargin: 8,
      elevation: 24,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 28.0,
              icon: const Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return typeOfTasksBottomSheet(listOfTask);
                  },
                );
              },
            ),
            IconButton(
              iconSize: 28.0,
              icon: const Icon(Icons.more_vert_rounded),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return moreMenuBottomSheet();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget moreMenuBottomSheet() {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetItem(
            title: "Sort by",
            onTap: () {
              Get.back();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Sort by",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            title: const Text(
                              "My order",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            value: 1,
                            groupValue: 2,
                            onChanged: (value) {},
                            contentPadding: const EdgeInsets.all(0),
                          ),
                          RadioListTile(
                            title: const Text(
                              "Date",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            value: 2,
                            groupValue: 2,
                            onChanged: (value) {},
                            contentPadding: const EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            subTitle: "My Order",
          ),
          const Divider(
            color: Colors.white24,
            thickness: 1,
            height: 1,
          ),
          BottomSheetItem(
            title: "Rename List",
            onTap: () {
              Get.to(() => const RenameTaskTypePage());
            },
          ),
          BottomSheetItem(
            title: "Delete List",
            onTap: () {},
          ),
          BottomSheetItem(
            title: "Delete all complete task",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget typeOfTasksBottomSheet(List<TaskType> listOfTask) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...listOfTask.map((e) {
            return TypeOfTaskBottomSheetListItem(
              title: e.name ?? "",
              isSelected: listOfTask[tabController?.index ?? 0] == e,
              onTap: () {
                Get.back();
                if (tabController == null) {
                  return;
                }
                tabController!.animateTo(listOfTask.indexOf(e));
              },
            );
          }).toList(),
          const Divider(
            color: Colors.white24,
            thickness: 1,
            height: 1,
          ),
          SizedBox(
            width: double.maxFinite,
            child: ListTile(
              title: const Text("Create new list"),
              contentPadding: const EdgeInsets.all(0),
              leading: const Icon(
                Icons.add,
                color: Colors.white60,
              ),
              onTap: () {
                Get.to(() => const AddTaskTypePage());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget customAppBar(
    BuildContext context,
    bool innerBoxIsScrolled,
    List<Widget> tabs,
    TabController tabController,
  ) {
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
          actions: appBarActions(tabController),
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade900,
            child: const FlutterLogo(),
          ),
          bottom: TabBar(
            controller: tabController,
            tabs: tabs,
            isScrollable: true,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: CustomUnderlineBarIndicator(
              color: Colors.blue,
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
          if (taskListController.taskTypes.isEmpty) {
            showToast("Add List Before add tasks");
            return;
          }
          Get.to(() => const AddTaskPage());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: bottomAppBar(),
      body: GetBuilder<TaskTypeController>(
        builder: (controller) {
          final tabs = taskListController.getTabs();
          tabController = TabController(
            length: tabs.length,
            vsync: this,
          );
          final typeOfTask = taskListController.taskTypes;

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
                    tabController!,
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

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    db
        .collection(TaskService.taskTypeCollection)
        .snapshots()
        .listen((querySnapshot) {
      final tempList =
          querySnapshot.docs.map((e) => TaskType.fromJson(e.data())).toList();
      taskListController.setNewLists(tempList);
    });
  }

  var _count = 0;
  var _tapPosition;

  void _showCustomMenu() {
    final RenderObject overlay =
        Overlay.of(context)!.context.findRenderObject()!;

    showMenu(
      context: context,
      items: <PopupMenuEntry<int>>[
        PlusMinusEntry(),
      ],
      position: RelativeRect.fromRect(
          _tapPosition & const Size(40, 40), // smaller rect, the touch area
          Offset.zero &
              overlay.semanticBounds.size // Bigger rect, the entire screen
          ),
    ).then<void>((int? delta) {
      // delta would be null if user taps on outside the popup menu
      // (causing it to close without making selection)
      if (delta == null) return;

      setState(() {
        _count = _count + delta;
      });
    });
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  Widget taskBodyView(TaskType typeOfTask) {
    if (typeOfTask.tasks != null) {
      final tasks = typeOfTask.tasks!;
      return SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() => EditTaskPage(task: tasks[index]));
                  },
                  onLongPress: _showCustomMenu,
                  onTapDown: _storePosition,
                  child: ListTile(
                    title: Text(
                      tasks[index].name ?? "",
                    ),
                  ),
                );
              },
            ),
            const Divider(
              thickness: 3,
            ),
            ExpansionTile(
              title: const Text("Complete (11)"),
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "Something $index",
                      style: const TextStyle(
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
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FlutterLogo(
            size: 120,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "No tasks yet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Add your to-dos",
            style: TextStyle(
              color: Colors.white60,
            ),
          )
        ],
      );
    }
    return FutureBuilder<List<Task>?>(
      future: taskService.getAllTasks(typeOfTask),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final tasks = snapshot.data;
        if (tasks == null || tasks.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FlutterLogo(
                size: 120,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "No tasks yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Add your to-dos",
                style: TextStyle(
                  color: Colors.white60,
                ),
              )
            ],
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => EditTaskPage(task: tasks[index]));
                    },
                    onLongPress: _showCustomMenu,
                    onTapDown: _storePosition,
                    child: ListTile(
                      title: Text(
                        tasks[index].name ?? "",
                      ),
                    ),
                  );
                },
              ),
              const Divider(
                thickness: 3,
              ),
              ExpansionTile(
                title: const Text("Complete (11)"),
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        "Something $index",
                        style: const TextStyle(
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
      },
    );
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

class PlusMinusEntry extends PopupMenuEntry<int> {
  PlusMinusEntry({Key? key}) : super(key: key);
  @override
  double height = 100;

  @override
  bool represents(int? value) => value == 1 || value == -1;

  @override
  PlusMinusEntryState createState() => PlusMinusEntryState();
}

class PlusMinusEntryState extends State<PlusMinusEntry> {
  void _plus1() {
    Navigator.pop<int>(context, 1);
  }

  void _minus1() {
    Navigator.pop<int>(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextButton(
            onPressed: _plus1,
            child: const Text('+1'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _minus1,
            child: const Text('-1'),
          ),
        ),
      ],
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    Key? key,
    required this.title,
    this.subTitle,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: (subTitle == null)
            ? null
            : Text(
                subTitle ?? "",
                style: const TextStyle(color: Colors.white12, fontSize: 12),
              ),
        onTap: onTap,
      ),
    );
  }
}

class TypeOfTaskBottomSheetListItem extends StatelessWidget {
  const TypeOfTaskBottomSheetListItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        leading: const Icon(
          Icons.ac_unit,
          color: Colors.transparent,
        ),
        onTap: onTap,
      ),
      decoration: isSelected
          ? const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: Colors.blue,
            )
          : null,
    );
  }
}
