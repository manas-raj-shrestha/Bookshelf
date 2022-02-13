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
    id = docId;
    title = json['title'];
    description = json['description'];
    completedAt = json['completed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['completed_at'] = completedAt;
    return data;
  }
}
