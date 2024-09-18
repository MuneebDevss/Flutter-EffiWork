import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:where_is_my_stuff/Core/Items/BusinessLogic/items_bloc.dart';
import 'package:where_is_my_stuff/Core/Items/DataSource/items_repos_impl.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Entity/item.dart';
import 'package:where_is_my_stuff/Core/Items/Domain/Repository/items_repository.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final GetIt injector = GetIt.instance;

Future<void> initialize() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(ItemAdapter());
  initializBloc();
}

void initializBloc() {
  // Register the ItemsRepository implementation
  injector.registerSingleton<ItemsRepository>(ItemsReposImpl());

  // Register the ItemsBloc with the injected ItemsRepository
  injector.registerSingleton(ItemsBloc(rep: injector<ItemsRepository>()));
}
