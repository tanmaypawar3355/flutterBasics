import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_31/firebase_options.dart';
import 'package:practice_flutter_application_31/services/alert_service.dart';
import 'package:practice_flutter_application_31/services/auth_service.dart';
import 'package:practice_flutter_application_31/services/media_service.dart';
import 'package:practice_flutter_application_31/services/navigation_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(NavigationService());
  getIt.registerSingleton(AlertService());
  getIt.registerSingleton(MediaService());
}
