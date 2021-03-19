import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final String email;
  DatabaseService({this.uid, this.email});

  //!COLLECTION REFERENCE
  final userCollection = FirebaseFirestore.instance.collection("User Data");

  Future updateUserData(
      {int noOfImages, int noOfVideos, int noOfAudios, int noOfFiles}) async {
    DocumentReference userReference = userCollection.doc(email);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      try {
        DocumentSnapshot snapshot = await transaction.get(userReference);
        if (!snapshot.exists) {
          print("UPDATE USER DATA - !SNAPSHOT.EXISTS");
          userReference.set({
            "Number of Images ": 0,
            "Number of Videos ": 0,
            "Number of Audios ": 0,
            "Number of Documents ": 0,
          });
        } else {
          print("UPDATE USER DATA - SNAPSHOT.EXISTS");
          if (noOfImages != null) {
            int newNoOfImages =
                await snapshot.data()["Number of Images "] + noOfImages;
            transaction
                .update(userReference, {"Number of Images ": newNoOfImages});
          } else if (noOfVideos != null) {
            int newNoOfVideos =
                await snapshot.data()["Number of Videos "] + noOfVideos;
            transaction
                .update(userReference, {"Number of Videos ": newNoOfVideos});
          } else if (noOfAudios != null) {
            int newNoOfAudios =
                await snapshot.data()["Number of Audios "] + noOfAudios;
            transaction
                .update(userReference, {"Number of Audios ": newNoOfAudios});
          } else if (noOfFiles != null) {
            int newNoOfFiles =
                await snapshot.data()["Number of Documents "] + noOfFiles;
            transaction
                .update(userReference, {"Number of Documents ": newNoOfFiles});
          } else {
            print("PASSED VALUE = 0 BLOCK GOT RUN !!!");
          }
        }
      } catch (e) {
        print("FIRESTORE TRANSACTION ERROR: $e");
      }
    }, timeout: Duration(minutes: 2));
  }

  //!GET USER STREAM
  Stream<QuerySnapshot> get userData {
    return userCollection.snapshots();
  }

  String getUserEmail() => email;
}
