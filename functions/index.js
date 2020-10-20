const functions = require('firebase-functions');

// LISTENS TO CHANGES ON THE CHAT COLLECTION, ON ANY DOCUMENTS
exports.myFunction = functions.firestore
  .document('chat/{message}')
  .onCreate((snapshot, context) => {
      console.log(snapshot.data());
  });