import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_42/models/chat.dart';
import 'package:practice_flutter_application_42/models/message.dart';
import 'package:practice_flutter_application_42/models/user_profile.dart';
import 'package:practice_flutter_application_42/services/auth_service.dart';
import 'package:practice_flutter_application_42/utils.dart';

class DatabaseService {
  final FirebaseFirestore _databaseService = FirebaseFirestore.instance;

  CollectionReference? _userCollection;
  CollectionReference? _chatCollection;
  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;

  DatabaseService() {
    _authService = _getIt.get<AuthService>();
    _createUserCollection();
  }

  Future<void> _createUserCollection() async {
    _userCollection = _databaseService
        .collection('users')
        .withConverter<UserProfile>(
          fromFirestore: (snapshot, _) =>
              UserProfile.fromJson(snapshot.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );

    ///////////////////////////////////////////////////////////////////////////

    _chatCollection = _databaseService
        .collection('chats')
        .withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  Future<void> createUserCollection({required UserProfile userProfile}) async {
    await _userCollection?.doc(userProfile.uid).set(userProfile);
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  Stream<QuerySnapshot<UserProfile>> getUserCollection() {
    return _userCollection
            ?.where("uid", isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final result = await _chatCollection?.doc(chatID).get();

    if (result != null) {
      return result.exists;
    }
    return false;
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);

    final docRef = _chatCollection?.doc(chatID);

    Chat chat = Chat(id: chatID, participants: [uid1, uid2], messages: []);
    docRef!.set(chat);
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  Future<void> sendChatMessage(
    String uid1,
    String uid2,
    Message message,
  ) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection?.doc(chatID);

    await docRef!.update({
      "messages": FieldValue.arrayUnion([message.toJson()]),
    });
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  Stream<DocumentSnapshot<Chat>> getChatData(String uid1, String uid2) {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    return _chatCollection?.doc(chatID).snapshots()
        as Stream<DocumentSnapshot<Chat>>;
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
}
