import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/controllers/task_list_controller.dart';
import 'package:todo_amplify/models/ModelProvider.dart';
import 'package:todo_amplify/utils/constant.dart';

class AddTypeOfTaskPage extends StatefulWidget {
  const AddTypeOfTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTypeOfTaskPage> createState() => _AddTypeOfTaskPageState();
}

class _AddTypeOfTaskPageState extends State<AddTypeOfTaskPage> {
  final typeOfTaskNameCon = TextEditingController();
  final taskListCon = Get.find<TaskListController>();
  bool hasText = false;

  Future<bool> saveToDatabase(String typeOfTaskName) async {
    final typeOfTask = TypeOfTask(
      name: typeOfTaskName,
    );

    try {
      await Amplify.DataStore.save(typeOfTask);
      // taskListCon.addNewList(typeOfTask, null);
      return true;
    } catch (e) {
      print('An error occurred while saving Todo: $e');
    }
    return false;
  }

  Future<void> saveTypeOfTask() async {
    final typeOfTaskName = typeOfTaskNameCon.text;
    final done = await saveToDatabase(typeOfTaskName);
    if (done) {
      showToast("Done");
      Get.back();
    } else {
      showToast("Problem");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Create new list"),
        actions: [
          TextButton(
            onPressed: hasText
                ? () {
                    saveTypeOfTask();
                  }
                : null,
            child: Text(
              "Done",
              style: TextStyle(
                color: hasText ? Colors.blue : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: typeOfTaskNameCon,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: 16,
                top: 16,
                bottom: 16,
              ),
              hintText: "Enter New List",
              border: OutlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade700,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade700,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                hasText = value.isNotEmpty;
              });
            },
          ),
        ],
      ),
    );
  }
}
