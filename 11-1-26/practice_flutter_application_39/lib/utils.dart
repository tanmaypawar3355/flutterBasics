import 'package:firebase_core/firebase_core.dart';
import 'package:practice_flutter_application_39/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_39/services/alert_service.dart';
import 'package:practice_flutter_application_39/services/auth_service.dart';
import 'package:practice_flutter_application_39/services/database_service.dart';
import 'package:practice_flutter_application_39/services/media_service.dart';
import 'package:practice_flutter_application_39/services/navigation_service.dart';
import 'package:practice_flutter_application_39/services/storage_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerSingleton(AuthService());
  getIt.registerSingleton(NavigationService());
  getIt.registerSingleton(AlertService());
  getIt.registerSingleton(MediaService());
  getIt.registerSingleton(StorageService());
  getIt.registerSingleton(DatabaseService());
}

String generateChatID({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}
