import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_28/firebase_options.dart';
import 'package:practice_flutter_application_28/services/authService.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt =  GetIt.instance;
  getIt.registerSingleton<Authservice>(Authservice());
}
