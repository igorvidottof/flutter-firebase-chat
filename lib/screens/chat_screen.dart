import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_module/widgets/chat/messages.dart';
import 'package:firebase_module/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ASKING FOR PERMISSIONS TO SEND PUSH NOTIFICATIONS ON IOS DEVICES
  @override
  void initState() {
    final firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.requestNotificationPermissions();

    // CONFIGURING PUSH NOTIFICATIONS
    firebaseMessaging.configure(
      // WHEN THE APP IS OPENED IN FOREGROUND
      onMessage: (message) {
        print(message);
        return;
      },
      // WHEN THE APP IS CLOSED
      onLaunch: (message) {
        print(message);
        return;
      },
      // WHEN THE APP IS OPENED IN BACKGROUND
      onResume: (message) {
        print(message);
        return;
      },
    );
    // THIS TOKEN IS USED SEND PUSH NOTIFICATIONS TO SPECIFIC DEVICES, IF NEEDED
    // IN A CHAT BETWEEN 2 PEOPLE, FOR EXAMPLE
    // firebaseMessaging.getToken();

    // THIS WILL MAKE ANY NOTIFICATION SET TO THIS TOPIC 'chat'
    // REACH THIS DEVICE
    firebaseMessaging.subscribeToTopic('chat');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (itemValue) {
              if (itemValue == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      // Stream is a type which emits a new value whenever a data source changes
      // builder reruns whenever some data changes
      body: Container(
        child: Column(
          children: [
            // Expanded MAKES THE MESSAGES LISTVIEW TAKE ALL THE SPACE OF THE SCREEN IT CAN GET
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
