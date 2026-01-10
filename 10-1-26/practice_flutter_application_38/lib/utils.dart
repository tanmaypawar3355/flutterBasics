import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_38/firebase_options.dart';
import 'package:practice_flutter_application_38/services/alert_servie.dart';
import 'package:practice_flutter_application_38/services/auth_service.dart';
import 'package:practice_flutter_application_38/services/database_service.dart';
import 'package:practice_flutter_application_38/services/media_service.dart';
import 'package:practice_flutter_application_38/services/navigation_service.dart';
import 'package:practice_flutter_application_38/services/storage_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt _getIt = GetIt.instance;
  _getIt.registerSingleton(AuthService());
  _getIt.registerSingleton(NavigationService());
  _getIt.registerSingleton(MediaService());
  _getIt.registerSingleton(AlertService());
  _getIt.registerSingleton(StorageService());
  _getIt.registerSingleton(DatabaseService());
}
