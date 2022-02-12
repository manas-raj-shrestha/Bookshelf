import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nytbooks/core/constants/screen_titles.dart';
import 'package:nytbooks/core/models/books_api_response.dart';
import 'package:nytbooks/core/services/firebase_service.dart';

import 'package:nytbooks/ui/index_page.dart';

import 'core/helper/dependency_injection.dart';
import 'core/models/book.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService.shared.initialise();
  FirebaseService.shared.tasks;

  Function? originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    if (originalOnError != null) originalOnError(errorDetails);
  };

  await dotenv.load(fileName: ".env");

  setupInjections();
  await initializeHive();

  runApp(const MyApp());
}

Future initializeHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BooksApiResponseAdapter());
  Hive.registerAdapter(BooksAdapter());
  await Hive.openBox<BooksApiResponse>('books');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: () => MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: IndexPage(),
      ),
    );
  }
}
