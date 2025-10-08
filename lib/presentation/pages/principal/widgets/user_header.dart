import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  final String userName;
  final String userImage;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onUserImagePressed;

  const UserHeader({
    super.key,
    required this.userName,
    required this.userImage,
    this.onNotificationPressed,
    this.onUserImagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onUserImagePressed,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(userImage),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 24),
            onPressed: onNotificationPressed,
          ),
        ],
      ),
    );
  }
}
