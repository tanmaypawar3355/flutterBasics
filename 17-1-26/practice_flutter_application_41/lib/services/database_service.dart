import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:pracctice_flutter_application_41/models/chat.dart';
import 'package:pracctice_flutter_application_41/models/message.dart';
import 'package:pracctice_flutter_application_41/models/user_profile.dart';
import 'package:pracctice_flutter_application_41/services/auth_service.dart';
import 'package:pracctice_flutter_application_41/utils.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseDatabase = FirebaseFirestore.instance;
  CollectionReference? _userCollection;
  CollectionReference? _chatCollection;

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;

  DatabaseService() {
    _createUserCollection();
    _authService = _getIt.get<AuthService>();
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  void _createUserCollection() {
    _userCollection = _firebaseDatabase
        .collection('users')
        .withConverter<UserProfile>(
          fromFirestore: (snapshot, _) =>
              UserProfile.fromJson(snapshot.data()!),
          toFirestore: (userProfile, _) => userProfile.toJson(),
        );

    ////////

    _chatCollection = _firebaseDatabase
        .collection('chats')
        .withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chats, _) => chats.toJson(),
        );
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  Future<void> createUserProfileCollection({
    required UserProfile userProfile,
  }) async {
    await _userCollection?.doc(userProfile.uid!).set(userProfile);
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  Stream<QuerySnapshot<UserProfile>> getUserProfile() {
    return _userCollection!
            .where("uid", isNotEqualTo: _authService.user!.uid)
            .snapshots()
        as Stream<QuerySnapshot<UserProfile>>;
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  // Future<void> createChatProfileCollection({required Chat chat}) async {
  //   await _chatCollection!.doc(chat.id!).set(chat);
  // }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final result = await _chatCollection?.doc(chatID).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);

    Chat chat = Chat(id: chatID, participants: [uid1, uid2], messages: []);

    await docRef.set(chat);
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  Future<void> sendChatMessage(
    String uid1,
    String uid2,
    Message message,
  ) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatCollection!.doc(chatID);
    await docRef.update({
      "messages": FieldValue.arrayUnion([message.toJson()]),
    });
  }

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  Stream<DocumentSnapshot<Chat>> getChatData(String uid1, String uid2) {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);

    return _chatCollection?.doc(chatID).snapshots()
        as Stream<DocumentSnapshot<Chat>>;
  }
}
