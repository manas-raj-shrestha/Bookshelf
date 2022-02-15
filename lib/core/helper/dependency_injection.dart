import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../network/dio_manager.dart';
import '../services/book_service.dart';
import '../services/firebase_service.dart';
import '../services/local_storage_service.dart';
import '../../view_models/home_view_model.dart';
import '../../view_models/task_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setupInjections() {
  serviceLocator.registerLazySingleton<ApiManager>(() => ApiManager());

  serviceLocator
      .registerLazySingleton<LocalStorageService>(() => LocalStorageService());

  serviceLocator.registerLazySingleton<HomeViewModel>(() =>
      HomeViewModel(serviceLocator<LocalStorageService>(), BookService()));

  serviceLocator
      .registerLazySingleton<FirebaseService>(() => FirebaseService());

  serviceLocator.registerLazySingleton<TaskViewModel>(
      () => TaskViewModel(serviceLocator<FirebaseService>()));
}
