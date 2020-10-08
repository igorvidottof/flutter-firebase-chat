import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stream is a type which emits a new value whenever a data source changes
      // builder reruns whenever some data changes
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('/chats/4zTCC33NBwtmFCVx1AWW/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            final querySnapshot = streamSnapshot.data as QuerySnapshot;
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = querySnapshot.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
