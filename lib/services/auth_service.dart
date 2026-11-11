import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _googleSignIn = GoogleSignIn.instance;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User get _user => _auth.currentUser!;
  User? get currentUser => _user;

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

    final user = UserDm.fromJson(userDoc.data() as Map<String, dynamic>);

    if (_user.email != null && _user.email != user.email) {
      await _firestore.collection('users').doc(user.id).update({
        'email': _user.email,
      });
      user.email = _user.email!;
    }

    return user;
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> updateProfileData({
    required String uid,
    required String newName,
  }) async {
    final userDoc = _firestore.collection('users').doc(uid);
    await userDoc.update({'name': newName.trim()});
  }

  Future<void> updateEmail(String newEmail) async {
    await _user.verifyBeforeUpdateEmail(newEmail.trim());
  }

  Future<void> reauthenticateWithPassword(String currentPassword) async {
    if (_user.email != null) {
      final credential = EmailAuthProvider.credential(
        email: _user.email!,
        password: currentPassword,
      );
      await _user.reauthenticateWithCredential(credential);
    }
  }

  Future<void> updatePassword(String newPassword) async {
    await _user.updatePassword(newPassword);
  }
}
