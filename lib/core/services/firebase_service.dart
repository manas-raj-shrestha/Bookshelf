import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nytbooks/core/models/task.dart';

class FirebaseService {
  static FirebaseService? _one;

  static FirebaseService get shared {
    return (_one == null ? (_one = FirebaseService._()) : _one!);
  }

  FirebaseService._();

  Future<void> initialise() => Firebase.initializeApp();

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  CollectionReference get tasksRef =>
      FirebaseFirestore.instance.collection('tasks');

  Future<List<Task>> get tasks async {
    QuerySnapshot snapshot = await tasksRef.get();

    // print(snapshot.docs);

    // snapshot.docs.forEach((element) {
    //   print(element.data() as Map<String, dynamic>);
    // });

    List<Task> transformedTasks = snapshot.docs
        .map((doc) => Task.fromJson(doc.id, doc.data() as Map<String, dynamic>))
        .toList();

    return transformedTasks;
  }

  //TODO: implement firestore CRUD functions here
  void addTask(Task task) {
    tasksRef.add(task.toJson());
  }
}
