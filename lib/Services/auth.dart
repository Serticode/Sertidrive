import 'package:firebase_auth/firebase_auth.dart';
import 'package:sertidrive/Models/user.dart';
import 'package:sertidrive/Services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //!CREATE USER OBJECT BASED ON FIREBASE USER
  MyUserModel _userFromFirebaseUser(User user) {
    return user != null
        ? MyUserModel(userID: user.uid, email: user.email)
        : null;
  }

  //! AUTH CHANGE USER STREAM
  Stream<MyUserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //! SIGN IN WITH EMAIL AND PASSWORD
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //! REGISTER WITH EMAIL AND PASSWORD
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      print("Account - ${user.email} created !");

      //!CREATE A NEW DOCUMENT FOR THE USER WITH USER EMAIL
      await DatabaseService(email: user.email).updateUserData(
        /* noOfImages: 0,
        noOfVideos: 0,
        noOfAudios: 0,
        noOfFiles: 0, */
      );
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("The provided password is weak !");
      } else if (e.code == "email-already-in-use") {
        print("The account already exists");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //! SIGN OUT
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
