import 'package:get_it/get_it.dart';
import 'package:nytbooks/core/network/dio_manager.dart';
import 'package:nytbooks/view_models/home_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setupInjections() {
  serviceLocator.registerLazySingleton<ApiManager>(() => ApiManager());
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
}
