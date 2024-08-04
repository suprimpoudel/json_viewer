import 'package:get_it/get_it.dart';
import 'package:json_viewer/feature/json_viewer/data/data_sources/json_viewer_data_source.dart';
import 'package:json_viewer/feature/json_viewer/data/repositories/json_viewer_repository_impl.dart';
import 'package:json_viewer/feature/json_viewer/domain/repositories/json_viewer_repository.dart';
import 'package:json_viewer/feature/json_viewer/domain/use_cases/json_viewer_use_case.dart';

var locator = GetIt.instance;

Future<void> appModuleSetup() async {
  locator.registerLazySingleton<JsonViewerRepository>(
    () => JsonViewerRepositoryImpl(JsonViewerDataSource()),
  );
  locator.registerFactory(() => JsonViewerUseCase(locator()));
}
