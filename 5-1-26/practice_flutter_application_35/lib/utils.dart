import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_35/firebase_options.dart';
import 'package:practice_flutter_application_35/services/alert_service.dart';
import 'package:practice_flutter_application_35/services/auth_service.dart';
import 'package:practice_flutter_application_35/services/database_service.dart';
import 'package:practice_flutter_application_35/services/media_service.dart';
import 'package:practice_flutter_application_35/services/navigation_service.dart';
import 'package:practice_flutter_application_35/services/storage_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<NavigationService>(NavigationService());
  getIt.registerSingleton<AlertService>(AlertService());
  getIt.registerSingleton<MediaService>(MediaService());
  getIt.registerSingleton<StorageService>(StorageService());
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}
