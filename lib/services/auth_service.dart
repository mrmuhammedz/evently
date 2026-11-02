import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _googleSignIn = GoogleSignIn.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> initGoogleSignIn() async {
    await _googleSignIn.initialize();
  }

  Future<UserDm> createUserByGoogle() async {
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final firebaseUser = userCredential.user!;

    final uid = firebaseUser.uid;
    final userDoc = _firestore.collection('users').doc(uid);
    final snapshot = await userDoc.get();

    if (snapshot.exists && snapshot.data() != null) {
      debugPrint('User already exists in Firestore: ${snapshot.data()}');
      return UserDm.fromJson(snapshot.data()!);
    }

    final user = UserDm(
      id: uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
    );

    await userDoc.set(user.toJson());
    return user;
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = UserDm(
      id: credential.user!.uid,
      name: name.trim(),
      email: email.trim(),
    );

    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserDm> loginUserByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final userDoc = await _firestore
        .collection('users')
        .doc(credential.user!.uid)
        .get();

    if (!userDoc.exists || userDoc.data() == null) {
      throw Exception('User data not found');
    }

    return UserDm.fromJson(userDoc.data() as Map<String, dynamic>);
  }
}
