import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/viewmodels/services/auth_services.dart';

class AuthProvider extends ChangeNotifier implements AuthServices {
  // instanze di oggetti Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? _user;
  ModelUser? _userData;

  AuthProvider() {
    _firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  ModelUser getUserData() {
    return _userData!;
  }

  @override
  Stream<ModelUser> fetchUserData() {
    return _firestore
        .collection("utenti")
        .doc(_firebaseAuth.currentUser!.uid)
        .snapshots()
        .map((doc) => ModelUser.fromJson(doc.data()!));
  }

  @override
  User? get currentUser => _user;

  @override
  bool isLogged() => _firebaseAuth.currentUser != null;

  @override
  Future<void> signin(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = cred.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  @override
  Future<void> signup(String email, String password, String username) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = cred.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  Future<void> _createUserData(UserCredential user, String username) async {
    try {
      await user.user?.updateDisplayName(username);
      final userDoc = _firestore
          .collection("utenti")
          .doc(user.user!.uid)
          .withConverter<ModelUser>(
            fromFirestore:
                (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

      await userDoc.set(
        ModelUser(
          profileImageUrl: null,
          uid: user.user!.uid,
          email: user.user!.email!,
          username: username,
          friendsList: [],
          pendingFriendsList: [],
        ),
      );
      _user = user.user;
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
      _userData = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code, e.message);
    }
  }

  @override
  Future<void> signout() async {
    await _firebaseAuth.signOut();
    _userData = null;
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
      await _firestore
          .collection("utenti")
          .doc(userId)
          .withConverter<ModelUser>(
            fromFirestore:
                (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .set(updatedUser);
      _userData = updatedUser;
      notifyListeners();
    } catch (e) {
      throw AuthException('update_failed', 'Failed to update user data');
    }
  }

  // gestione amicizie

  @override
  Future<void> acceptFriendRequest(String userId) async {
    try {
      final currentUserRef = _firestore
          .collection("utenti")
          .doc(_firebaseAuth.currentUser!.uid);
      final requesterRef = _firestore.collection("utenti").doc(userId);

      // Aggiorna l'utente corrente: rimuovi da pending, aggiungi a friends
      await currentUserRef.update({
        "pendingFriendsList": FieldValue.arrayRemove([userId]),
        "friendsList": FieldValue.arrayUnion([userId]),
      });

      // Aggiorna anche l'altro utente: aggiungi currentUser alla sua friendsList
      await requesterRef.update({
        "friendsList": FieldValue.arrayUnion([_firebaseAuth.currentUser!.uid]),
      });
    } catch (e) {
      throw AuthException(
        "Errore nell'accettare la richiesta: ${e.toString()}",
      );
    }
  }

  @override
  Future<void> rejectFriendRequest(String userId) async {
    try {
      final currentUserRef = _firestore
          .collection("utenti")
          .doc(_firebaseAuth.currentUser!.uid);

      // Rimuovi l'UID dalla pending list
      await currentUserRef.update({
        "pendingFriendsList": FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      throw AuthException("Errore nel rifiutare la richiesta: ${e.toString()}");
    }
  }
  @override
  Future<void> removeFriend(String userId) async {
    try {
      final currentUserRef = _firestore
          .collection("utenti")
          .doc(_firebaseAuth.currentUser!.uid);
      final friendRef = _firestore.collection("utenti").doc(userId);

      // Rimuovi l'amico dalla lista amici dell'utente corrente
      await currentUserRef.update({
        "friendsList": FieldValue.arrayRemove([userId]),
      });

      // Rimuovi l'utente corrente dalla lista amici dell'amico
      await friendRef.update({
        "friendsList": FieldValue.arrayRemove([_firebaseAuth.currentUser!.uid]),
      });
    } catch (e) {
      throw AuthException("Errore nella rimozione dell'amico: ${e.toString()}");
    }
  }
  @override
  Future<void> sendFriendRequest(String userId) async {
    try {
      final currentUserRef = _firestore
          .collection("utenti")
          .doc(_firebaseAuth.currentUser!.uid);
      final receiverRef = _firestore.collection("utenti").doc(userId);

      // Aggiungi l'UID alla pending list del destinatario
      await receiverRef.update({
        "pendingFriendsList": FieldValue.arrayUnion([_firebaseAuth.currentUser!.uid]),
      });
    } catch (e) {
      throw AuthException("Errore nell'invio della richiesta: ${e.toString()}");
    }
  }

  @override
  Stream<List<ModelUser>> getFriendsRequests() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Stream.empty(); // Oppure throw se preferisci
    }

    final userDocStream =
        _firestore
            .collection("utenti")
            .doc(currentUser.uid)
            .withConverter(
              fromFirestore:
                  (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            )
            .snapshots();

    return userDocStream.asyncMap((docSnapshot) async {
      if (!docSnapshot.exists) return [];

      final pendingFriendsUidList = docSnapshot.data()!.getPendingFriendsList;

      if (pendingFriendsUidList.isEmpty) return [];

      final chunks = <List<String>>[];
      for (var i = 0; i < pendingFriendsUidList.length; i += 10) {
        chunks.add(
          pendingFriendsUidList.sublist(
            i,
            i + 10 > pendingFriendsUidList.length
                ? pendingFriendsUidList.length
                : i + 10,
          ),
        );
      }

      List<ModelUser> pendingFriendsList = [];

      for (final chunk in chunks) {
        final querySnapshot =
            await _firestore
                .collection("utenti")
                .where(FieldPath.documentId, whereIn: chunk)
                .withConverter(
                  fromFirestore:
                      (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
                  toFirestore: (model, _) => model.toJson(),
                )
                .get();

        pendingFriendsList.addAll(querySnapshot.docs.map((doc) => doc.data()));
      }

      return pendingFriendsList;
    });
  }

  @override
  Stream<List<ModelUser>> getFriendsList() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }

    final userDocStream =
        _firestore
            .collection("utenti")
            .doc(currentUser.uid)
            .withConverter(
              fromFirestore:
                  (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            )
            .snapshots();

    return userDocStream.asyncMap((docSnapshot) async {
      if (!docSnapshot.exists) return [];

      final friendsUidList = docSnapshot.data()!.getFriendsList;

      if (friendsUidList.isEmpty) return [];

      final chunks = <List<String>>[];
      for (var i = 0; i < friendsUidList.length; i += 10) {
        chunks.add(
          friendsUidList.sublist(
            i,
            i + 10 > friendsUidList.length ? friendsUidList.length : i + 10,
          ),
        );
      }

      List<ModelUser> friendsList = [];

      for (final chunk in chunks) {
        final querySnapshot =
            await _firestore
                .collection("utenti")
                .where(FieldPath.documentId, whereIn: chunk)
                .withConverter(
                  fromFirestore:
                      (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
                  toFirestore: (model, _) => model.toJson(),
                )
                .get();

        friendsList.addAll(querySnapshot.docs.map((doc) => doc.data()));
      }

      return friendsList;
    });
  }

  @override
  Stream<List<ModelUser>> getAllUsersExceptCurrentUserAndFriendsAndPending() {

    final userDocStream = _firestore
        .collection("utenti")
        .doc(_firebaseAuth.currentUser!.uid)
        .withConverter(
          fromFirestore: (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();

    return userDocStream.asyncMap((docSnapshot) async {
      if (!docSnapshot.exists) return [];

      final currentUserData = docSnapshot.data()!;
      final friendsList = currentUserData.getFriendsList;
      final pendingList = currentUserData.getPendingFriendsList;

      final excludedUsers = [...friendsList, ...pendingList, _firebaseAuth.currentUser!.uid];

      final querySnapshot = await _firestore
          .collection("utenti")
          .where(FieldPath.documentId, whereNotIn: excludedUsers)
          .withConverter(
            fromFirestore: (snapshot, _) => ModelUser.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .get();

      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}

class AuthException implements Exception {
  final String code;
  final String? message;

  AuthException(this.code, [this.message]);

  @override
  String toString() =>
      'AuthException: $code${message != null ? ' - $message' : ''}';
}
