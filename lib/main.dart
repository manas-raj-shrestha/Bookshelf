import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/ui/home/home_screen.dart';

import 'core/helper/dependency_injection.dart';
import 'core/models/book.dart';

void main() async {
  setupInjections();
  await initializeHive();
  runApp(const MyApp());
}

Future initializeHive() async {
  await Hive.initFlutter();
  print('#1');
  Hive.registerAdapter(BooksApiResponseAdapter());
  print('#2');
  Hive.registerAdapter(BooksAdapter());
  print('#3');
  await Hive.openBox<BooksApiResponse>('books');
  print('#4');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MaterialApp(
        title: 'Bookshelf',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
