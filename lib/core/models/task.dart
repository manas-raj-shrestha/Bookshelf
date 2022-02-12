import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String? id;
  String? title;
  String? description;
  String? completedAt;

  Task({this.id, this.title, this.description, this.completedAt});

  bool get isNew {
    return id == null;
  }

  bool get isCompleted {
    return completedAt != null;
  }

  void toggleComplete() {
    if (isCompleted) {
      completedAt = null;
    } else {
      completedAt = DateTime.now().toIso8601String();
    }
  }

  Task.fromJson(String docId, Map<String, dynamic> json) {
    print(docId);
    id = docId;
    title = json['title'];
    description = json['description'];
    completedAt = (json['completed_at'] != null)
        ? (json['completed_at'] as Timestamp).toDate().toIso8601String()
        : json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['completed_at'] = this.completedAt;
    return data;
  }
}
