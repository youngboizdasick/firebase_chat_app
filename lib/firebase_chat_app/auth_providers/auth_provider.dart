import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/constants.dart';
import 'package:firebase_chat_app/firebase_chat_app/models/user_chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences prefs;

  Status _status = Status.uninitialized;

  Status get status => _status;

  AuthProvider({
    required this.googleSignIn,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.prefs,
  });

  String? getUserFirebaseId() {
    return prefs.getString(FirebaseConstants.id);
  }

  Future<bool> isLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn && getUserFirebaseId()?.isNotEmpty == true) {
      return true;
    }
    return false;
  }

  Future<bool> handleSignIn() async {
    _status = Status.authenticating;
    notifyListeners();

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      User? firebaseUser = (await firebaseAuth.signInWithCredential(authCredential)).user;

      if (firebaseUser != null) {
        await _saveUserData(firebaseUser);
        print(firebaseUser);
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticateError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }

  Future<void> _saveUserData(User firebaseUser) async {
    final QuerySnapshot result = await firebaseFirestore
        .collection(FirebaseConstants.pathUserCollection)
        .where(FirebaseConstants.id, isEqualTo: firebaseUser.uid)
        .get();

    if (result.docs.isEmpty) {
      await firebaseFirestore.collection(FirebaseConstants.pathUserCollection).doc(firebaseUser.uid).set({
        FirebaseConstants.id: firebaseUser.uid,
        FirebaseConstants.nickname: firebaseUser.displayName,
        FirebaseConstants.photoUrl: firebaseUser.photoURL,
        'createAt': DateTime.now().microsecondsSinceEpoch.toString(),
        FirebaseConstants.chattingWith: null,
      });

      await _saveUserToPreferences(firebaseUser);
    } else {
      DocumentSnapshot documentSnapshot = result.docs.first;
      UserChat userChat = UserChat.fromDocument(documentSnapshot);
      await _saveUserChatToPreferences(userChat);
    }
  }

  Future<void> _saveUserToPreferences(User firebaseUser) async {
    await prefs.setString(FirebaseConstants.id, firebaseUser.uid);
    await prefs.setString(FirebaseConstants.nickname, firebaseUser.displayName ?? '');
    await prefs.setString(FirebaseConstants.photoUrl, firebaseUser.photoURL ?? '');
    await prefs.setString(FirebaseConstants.phoneNumber, firebaseUser.phoneNumber ?? '');
  }

  Future<void> _saveUserChatToPreferences(UserChat userChat) async {
    await prefs.setString(FirebaseConstants.id, userChat.id!);
    await prefs.setString(FirebaseConstants.nickname, userChat.nickname ?? '');
    await prefs.setString(FirebaseConstants.photoUrl, userChat.photoUrl ?? '');
    await prefs.setString(FirebaseConstants.aboutMe, userChat.aboutMe ?? '');
    await prefs.setString(FirebaseConstants.phoneNumber, userChat.phoneNumber ?? '');
  }
}
