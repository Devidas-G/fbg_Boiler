import 'package:fbg/core/providers/config_pr.dart';
import 'package:fbg/core/services/config_s.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setuplocators() {
  locator.registerLazySingleton(() => ConfigService());
  locator.registerLazySingleton(() => ConfigModel());
}
