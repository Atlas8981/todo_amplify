import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/controllers/TaskTypeController.dart';
import 'package:todo_amplify/services/TaskService.dart';
import 'package:todo_amplify/utils/constant.dart';

class AddTaskTypePage extends StatefulWidget {
  const AddTaskTypePage({Key? key}) : super(key: key);

  @override
  State<AddTaskTypePage> createState() => _AddTaskTypePageState();
}

class _AddTaskTypePageState extends State<AddTaskTypePage> {
  final typeOfTaskNameCon = TextEditingController();
  final taskListCon = Get.find<TaskTypeController>();
  final taskService = TaskService();
  bool hasText = false;

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
                    onDoneButtonTap();
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
              hintText: "Enter list's name",
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

  Future<void> onDoneButtonTap() async {
    setState(() {
      hasText = false;
    });
    final taskTypeName = typeOfTaskNameCon.text;
    if (taskTypeName.isNotEmpty) {
      final isDone = await taskService.addTaskTypes(taskTypeName);
      if (isDone) {
        Get.back();
      } else {
        showToast("Something went wrong");
      }
    }
    setState(() {
      hasText = true;
    });
  }
}
