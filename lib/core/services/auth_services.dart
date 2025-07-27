import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServicess {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  User? get currentUser => auth.currentUser;

  UserInfo get userInfo {
    if (auth.currentUser != null) {
      return auth.currentUser!.providerData[0];
    }

    return UserInfo.fromJson({
      "providerId": '',
      "uid": "anonymous",
      "displayName": "Anonymous User",
      "email": 'null',
      "photoURL": null,
      "phoneNumber": '',
      "isAnonymous": true,
      "tenantId": '',
      "metadata": {"creationTime": '', "lastSignInTime": ''},
      "providerData": [],
      "refreshToken": '',
      "emailVerified": false,
      "stsTokenManager": {
        "accessToken": '',
        "expirationTime": '',
        "refreshToken": '',
      },
      "idToken": '',
      "apiKey": '',
      "appName": '',
      "isEmailVerified": false,
      "phoneNumberVerified": false,
      "isAnonymousUser": true,
    });
  }

  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  bool userStillLogedIn() {
    return auth.currentUser != null;
  }

  Future<UserCredential> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    var user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await firestore.collection('users').doc(auth.currentUser!.uid).set({
      'userName': name,
      'score': 0,
      'email': email,
      'uid': auth.currentUser!.uid,
      'createdAt': DateTime.now(),
    });

    return user;
  }

  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    deleteUserAndField();
    await signOut();
  }

  Future<void> updateUserName({required String name}) async {
    await currentUser!.updateDisplayName(name);
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  deleteUserAndField() {
    firestore.collection('users').doc(auth.currentUser!.uid).delete();
  }

 
}
