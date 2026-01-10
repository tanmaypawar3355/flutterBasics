import 'package:flutter/material.dart';
import 'package:practice_flutter_application_38/models/user_profile.dart';

class ChatTile extends StatelessWidget {
  final UserProfile userProfile;
  final Function onTap;

  const ChatTile({super.key, required this.userProfile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: CircleAvatar(backgroundImage: NetworkImage(userProfile.pfpURL!)),
      title: Text(userProfile.name!),
    );
  }
}
