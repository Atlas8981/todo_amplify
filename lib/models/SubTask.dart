import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SubTask {
  final String id;
  final String? name;
  final String? description;
  final bool? isComplete;
  final Timestamp? deadline;
  final int? order;
  final String? taskID;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  SubTask({
    required this.id,
    this.name,
    this.description,
    this.isComplete,
    this.deadline,
    this.order,
    this.taskID,
    this.createdAt,
    this.updatedAt,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) => SubTask(
    id: json["id"],
    createdAt: (json["createdAt"] is int)
        ? Timestamp.fromDate(
      DateTime.fromMillisecondsSinceEpoch(json["createdAt"]),
    )
        : json["createdAt"],
    updatedAt: (json["updatedAt"] is int)
        ? Timestamp.fromDate(
      DateTime.fromMillisecondsSinceEpoch(json["updatedAt"]),
    )
        : json["updatedAt"],
    deadline: (json["deadline"] is int)
        ? Timestamp.fromDate(
      DateTime.fromMillisecondsSinceEpoch(json["deadline"]),
    )
        : json["deadline"],
    name: json["name"],
    isComplete: json["isComplete"],
    order: json["order"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "deadline": deadline,
    "isComplete": isComplete,
    "order": order,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
