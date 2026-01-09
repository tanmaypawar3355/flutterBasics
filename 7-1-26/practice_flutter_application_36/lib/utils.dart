import "package:firebase_core/firebase_core.dart";
import "package:get_it/get_it.dart";
import "package:practice_flutter_application_36/firebase_options.dart";
import "package:practice_flutter_application_36/services/alert_service.dart";
import "package:practice_flutter_application_36/services/auth_Service.dart";
import "package:practice_flutter_application_36/services/database_service.dart";
import "package:practice_flutter_application_36/services/media_service.dart";
import "package:practice_flutter_application_36/services/navigation_service.dart";
import "package:practice_flutter_application_36/services/storage_service.dart";

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt _getIt = GetIt.instance;

  _getIt.registerSingleton<AuthService>(AuthService());
  _getIt.registerSingleton<NavigationService>(NavigationService());
  _getIt.registerSingleton<MediaService>(MediaService());
  _getIt.registerSingleton<StorageService>(StorageService());
  _getIt.registerSingleton<AlertService>(AlertService());
  _getIt.registerSingleton<DatabaseService>(DatabaseService());
}
