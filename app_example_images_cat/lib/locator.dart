


import 'package:app_example_images_cat/data/repositories/cat_repository.dart';
import 'package:app_example_images_cat/presentation/notifier/cat_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final locator = GetIt.instance;


void init(){
  ///notifier
  locator.registerLazySingleton<CatNotifier>(() => CatNotifier(locator()));
  ///repository
  locator.registerLazySingleton<CatRepository>(() => CatRepository(locator()));
  ///external i.e http client
  locator.registerLazySingleton<Client>(() => Client());
}