import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scorevault/viewmodels/services/auth_services.dart';

/// implemento i metodi dall'interfaccia AuthService.
/// Approcio singleton per quanto riguarda l'instanza firebaseAuth

class AuthProvider extends ChangeNotifier implements AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseAuth get getFirebaseAuthInstance => _firebaseAuth;
  bool isLogged() {
    if (_firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<UserCredential> signin(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  @override
  Future<UserCredential> signup(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _createUserData(userCredential, username);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> _createUserData(UserCredential? user, String username) async {
    // aggiorno subito il nome utente nuovo, seperato dalla registrazione.
    // creo il documento
    _firebaseAuth.currentUser!.updateDisplayName(username);

    if (user != null && user.user != null) {
      await FirebaseFirestore.instance
          .collection("utenti")
          .doc(user.user!.uid)
          .set({'email': user.user!.email, 'username': username, 'friends': []});
    }
  }

  @override
  Future<void> deleteUser() async {
    // elimino il documento associato all'utente
    await FirebaseFirestore.instance
        .collection("utenti")
        .doc(_firebaseAuth.currentUser!.uid)
        .delete();
    await _firebaseAuth.currentUser!.delete();
  }

  @override
  Future<void> signout() async {
    _firebaseAuth.signOut();
  }
}
