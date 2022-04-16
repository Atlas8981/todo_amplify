import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/controllers/task_type_controller.dart';

class RenameTaskTypePage extends StatefulWidget {
  const RenameTaskTypePage({
    Key? key,
  }) : super(key: key);

  @override
  State<RenameTaskTypePage> createState() => _RenameTaskTypePageState();
}

class _RenameTaskTypePageState extends State<RenameTaskTypePage> {
  final typeOfTaskNameCon = TextEditingController();
  final taskListCon = Get.find<TaskTypeController>();
  bool hasText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Rename list"),
        actions: [
          TextButton(
            onPressed: hasText ? () {} : null,
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
