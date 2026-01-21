import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_45/models/chat.dart';
import 'package:practice_flutter_application_45/models/message.dart';
import 'package:practice_flutter_application_45/models/user_profile.dart';
import 'package:practice_flutter_application_45/services/auth_service.dart';
import 'package:practice_flutter_application_45/utils.dart';

class DatabaseService {
  final FirebaseFirestore _databaseService = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  CollectionReference? _chatCollection;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;

  DatabaseService() {
    _createUserProfileCollection();
    _authService = _getIt.get<AuthService>();
  }

  Future<void> _createUserProfileCollection() async {
    _userCollection = _databaseService
        .collection('users')
        .withConverter<UserProfile>(
          fromFirestore: (snapshot, _) =>
              UserProfile.fromJson(snapshot.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );

    //////////////
    _chatCollection = _databaseService
        .collection("chats")
        .withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chat, _) => chat.toJson(),
        );
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  void createUserProfile(UserProfile userProfile) async {
    await _userCollection?.doc(userProfile.uid).set(userProfile);
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  Stream<QuerySnapshot<UserProfile>> getUserProfile() {
    return _userCollection!
            .where('uid', isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  Future<bool> checkChatExist(String uid1, String uid2) async {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);

    final result = await _chatCollection?.doc(chatID).get();

    if (result != null) {
      return result.exists;
    }
    return false;
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);

    Chat chat = Chat(id: chatID, participants: [uid1, uid2], messages: []);

    await docRef.set(chat);
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  Future<void> sendMessageToDatabase(
    String uid1,
    String uid2,
    Message message,
  ) async {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection?.doc(chatID);

    await docRef!.update({
      "messages": FieldValue.arrayUnion([message.toJson()]),
    });
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////

  Stream<DocumentSnapshot<Chat>> getChatData(String uid1, String uid2) {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);

    return _chatCollection!.doc(chatID).snapshots()
        as Stream<DocumentSnapshot<Chat>>;
  }

  /////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////
}
