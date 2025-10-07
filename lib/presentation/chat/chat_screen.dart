import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://cdn3d.iconscout.com/3d/premium/thumb/boy-avatar-3d-icon-png-download-5187865.png',
            ),
          ),
        ),
        title: const Text('Mi amor ❤️'),
        centerTitle: true,
      ),
      body: Center(child: const Text('Chat Screen')),
    );
  }
}
