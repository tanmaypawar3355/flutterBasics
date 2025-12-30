import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_30/firebase_options.dart';
import 'package:practice_flutter_application_30/services/auth_service.dart';
import 'package:practice_flutter_application_30/services/navigation_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt _getIt = GetIt.instance;
   _getIt.registerSingleton(AuthService());
   _getIt.registerSingleton(NavigationService());
}
