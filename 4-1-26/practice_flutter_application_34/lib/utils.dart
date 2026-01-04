import 'package:firebase_core/firebase_core.dart';
import 'package:practice_flutter_application_34/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_34/services/alert_service.dart';
import 'package:practice_flutter_application_34/services/auth_service.dart';
import 'package:practice_flutter_application_34/services/media_service.dart';
import 'package:practice_flutter_application_34/services/navigation_service.dart';
import 'package:practice_flutter_application_34/services/storage_service.dart';

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

}
