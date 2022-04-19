import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showCustomDateTimePicker({
  context,
  required Function(DateTime date) onConfirm,
  required DateTime? currentTime,
}) async {
  Get.bottomSheet(
    cupertinoDateTimePicker(
      onConfirm: (date) {
        onConfirm(date);
      },
      currentTime: currentTime,
    ),
    backgroundColor: Colors.white,
    enableDrag: false,
  );
}

Widget cupertinoDateTimePicker({
  required Function(DateTime date) onConfirm,
  required DateTime? currentTime,
}) {
  final now = DateTime.now();
  DateTime? picked;
  return SizedBox(
    height: 250,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "cancel".tr,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (picked != null) {
                    onConfirm(picked!);
                  } else {
                    onConfirm(DateTime.now());
                  }
                  Get.back();
                },
                child: const Text("Confirm"),
              )
            ],
          ),
        ),
        Expanded(
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: currentTime ?? now,
            onDateTimeChanged: (val) {
              picked = val;
            },
            minimumDate: now,
          ),
        ),
      ],
    ),
  );
}
