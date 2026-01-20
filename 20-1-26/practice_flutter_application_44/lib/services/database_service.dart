import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_flutter_application_44/models/chat.dart';
import 'package:practice_flutter_application_44/models/message.dart';
import 'package:practice_flutter_application_44/models/user_profile.dart';
import 'package:practice_flutter_application_44/services/auth_service.dart';
import 'package:practice_flutter_application_44/utils.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  CollectionReference? _chatCollection;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;

  DatabaseService() {
    _createUserCcollection();
    _authService = _getIt.get<AuthService>();
  }

  void _createUserCcollection() {
    _userCollection = _firebaseFirestore
        .collection("users")
        .withConverter<UserProfile>(
          fromFirestore: (snapshot, _) =>
              UserProfile.fromJson(snapshot.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );

    /////////////////////////////////
    _chatCollection = _firebaseFirestore
        .collection('chats')
        .withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chats, _) => chats.toJson(),
        );
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Future<void> createNewUserProfile(UserProfile userProfile) async {
    await _userCollection?.doc(userProfile.uid).set(userProfile);
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Stream<QuerySnapshot<UserProfile>> getUserProfileCollection() {
    return _userCollection
            ?.where('uid', isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);
    final result = await _chatCollection?.doc(chatID).get();

    if (result != null) {
      return result.exists;
    }
    return false;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection?.doc(chatID);

    Chat chat = Chat(id: chatID, participants: [uid1, uid2], messages: []);

    docRef!.set(chat);
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Future<void> sendMessageToDatabase(
    String uid1,
    String uid2,
    Message message,
  ) async {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);

    docRef.update({
      "messages": FieldValue.arrayUnion([message.toJson()]),
    });
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  Stream<DocumentSnapshot<Chat>> getChatData(String uid1, String uid2) {
    String chatID = generateChatId(uid1: uid1, uid2: uid2);
    return _chatCollection!.doc(chatID).snapshots() as Stream<DocumentSnapshot<Chat>>;
  }

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////
}
