import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nytbooks/ui/home/home_screen.dart';

import 'core/helper/dependency_injection.dart';

void main() {
  setupInjections();
  runApp(const MyApp());
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
