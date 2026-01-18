import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:pracctice_flutter_application_41/firebase_options.dart';
import 'package:pracctice_flutter_application_41/services/alert_service.dart';
import 'package:pracctice_flutter_application_41/services/auth_service.dart';
import 'package:pracctice_flutter_application_41/services/database_service.dart';
import 'package:pracctice_flutter_application_41/services/media_service.dart';
import 'package:pracctice_flutter_application_41/services/navigation_service.dart';
import 'package:pracctice_flutter_application_41/services/storage_service.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt _getIt = GetIt.instance;

  _getIt.registerSingleton(AuthService());
  _getIt.registerSingleton(NavigationService());
  _getIt.registerSingleton(AlertService());
  _getIt.registerSingleton(MediaService());
  _getIt.registerSingleton(StorageService());
  _getIt.registerSingleton(DatabaseService());
}

String generateChatID({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}
