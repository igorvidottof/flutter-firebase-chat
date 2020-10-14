import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_module/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final querySnapshot = chatSnapshot.data as QuerySnapshot;
            final documents = querySnapshot.documents;
            return ListView.builder(
              // REVERSE MAKES THE LISTVIEW SCROLL FROM BOTTOM TO TOP
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) => MessageBubble(
                documents[index]['text'],
                documents[index]['userId'] == futureSnapshot.data.uid,
                documents[index]['username'],
                key: ValueKey(documents[index].documentID),
              ),
            );
          },
        );
      },
    );
  }
}
