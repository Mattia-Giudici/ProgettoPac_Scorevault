import 'package:firebase_auth/firebase_auth.dart';

// con dart, la definizione di interfacce è implicita quando si creano classi astratte.
abstract class AuthServices {
  Future<UserCredential> signin(String email, String password);
  Future<UserCredential>  signup(String email, String password, String username);
  Future<void> signout();
  Future<void> deleteUser();
} 