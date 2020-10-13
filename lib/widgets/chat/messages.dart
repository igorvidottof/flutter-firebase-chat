import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          itemBuilder: (ctx, index) => Text(
            documents[index]['text'],
          ),
        );
      },
    );
  }
}
