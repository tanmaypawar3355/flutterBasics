import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_45/firebase_options.dart';
import 'package:practice_flutter_application_45/services/alert_service.dart';
import 'package:practice_flutter_application_45/services/auth_service.dart';
import 'package:practice_flutter_application_45/services/database_service.dart';
import 'package:practice_flutter_application_45/services/media_service.dart';
import 'package:practice_flutter_application_45/services/navigation_service.dart';
import 'package:practice_flutter_application_45/services/storage_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerService() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(NavigationService());
  getIt.registerSingleton(AlertService());
  getIt.registerSingleton(MediaService());
  getIt.registerSingleton(StorageService());
  getIt.registerSingleton(DatabaseService());
}

String generateChatId({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}
