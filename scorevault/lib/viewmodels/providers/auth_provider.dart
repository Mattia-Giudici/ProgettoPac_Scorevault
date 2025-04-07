import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/viewmodels/services/auth_services.dart';

class AuthProvider extends ChangeNotifier implements AuthServices {
  
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  
  // Cache dell'utente corrente
  ModelUser? _cachedUser;
  User? get currentFirebaseUser => _firebaseAuth.currentUser;
  ModelUser? get currentUser => _cachedUser;

  AuthProvider({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance {
    // Inizializza l'utente al creare il provider
    initializeUser();
    
    // Ascolta i cambiamenti di stato dell'autenticazione
    _firebaseAuth.authStateChanges().listen((user) async {
      if (user != null) {
        await _fetchAndCacheUser(user.uid);
      } else {
        _cachedUser = null;
      }
      notifyListeners();
    });
  }

  Future<void> initializeUser() async {
    if (_firebaseAuth.currentUser != null) {
      await _fetchAndCacheUser(_firebaseAuth.currentUser!.uid);
    }
  }

  Future<void> _fetchAndCacheUser(String userId) async {
    try {
      final doc = await _firestore.collection("utenti").doc(userId)
        .withConverter<ModelUser>(
          fromFirestore: (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();

      _cachedUser = doc.data();
    } catch (e) {
      _cachedUser = null;
    }
  }

  @override
  bool isLogged() => _firebaseAuth.currentUser != null;

  @override
  Future<UserCredential> signin(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      await _fetchAndCacheUser(userCredential.user!.uid);
      notifyListeners();
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  @override
  Future<UserCredential> signup(
    String email,
    String password,
    String username,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _createUserData(userCredential, username);
      await _fetchAndCacheUser(userCredential.user!.uid);
      notifyListeners();
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  Future<void> _createUserData(UserCredential user, String username) async {
    try {
      await user.user?.updateDisplayName(username);
      
      final userDoc = _firestore.collection("utenti").doc(user.user!.uid)
        .withConverter<ModelUser>(
          fromFirestore: (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

      await userDoc.set(ModelUser(
        uid: user.user!.uid,
        email: user.user!.email!,
        username: username,
        friendsList: [],
        pendingFriendsList: [],
      ));
    } catch (e) {
      await user.user?.delete();
      rethrow;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      await _firestore.collection("utenti").doc(userId).delete();
      await _firebaseAuth.currentUser!.delete();
      _cachedUser = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  @override
  Future<void> signout() async {
    await _firebaseAuth.signOut();
    _cachedUser = null;
    notifyListeners();
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  /// Aggiorna i dati dell'utente nel cache e nel database
  Future<void> updateUser(ModelUser updatedUser) async {
    try {
      final userId = _firebaseAuth.currentUser!.uid;
      await _firestore.collection("utenti").doc(userId)
        .withConverter<ModelUser>(
          fromFirestore: (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .set(updatedUser);
      
      _cachedUser = updatedUser;
      notifyListeners();
    } catch (e) {
      throw AuthException('update_failed', 'Failed to update user data');
    }
  }
}

class AuthException implements Exception {
  final String code;
  final String? message;

  AuthException(this.code, [this.message]);

  @override
  String toString() => 'AuthException: $code${message != null ? ' - $message' : ''}';
}
