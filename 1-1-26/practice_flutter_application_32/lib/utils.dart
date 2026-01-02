import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_32/firebase_options.dart';
import 'package:practice_flutter_application_32/services/alert_service.dart';
import 'package:practice_flutter_application_32/services/auth_service.dart';
import 'package:practice_flutter_application_32/services/media_services.dart';
import 'package:practice_flutter_application_32/services/navigation_service.dart';

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
