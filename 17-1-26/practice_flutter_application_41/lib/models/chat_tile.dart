import 'package:flutter/material.dart';
import 'package:pracctice_flutter_application_41/models/user_profile.dart';

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
      title: Text(userProfile.name!),
      dense: false,
      leading: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
        child: CircleAvatar(
          backgroundImage: NetworkImage(userProfile.pfpURL!),
          radius: 25,
        ),
      ),
    );
  }
}
