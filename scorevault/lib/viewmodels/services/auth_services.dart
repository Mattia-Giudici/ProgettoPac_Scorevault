import 'package:scorevault/Models/model_user.dart';

// con dart, la definizione di interfacce è implicita quando si creano classi astratte.
abstract class AuthServices {

  // gestione CRUD utente e autenticazione
  Future<void> signin(String email, String password);
  Future<void>  signup(String email, String password, String username);
  Future<void> signout();
  Future<void> deleteUser();

  // gestione notifiche amicizie
  Future<void> sendFriendRequest(String userId);
  Future<List<ModelUser>> getFriendsRequests();
  Future<void> acceptFriendRequest(String userId);
  Future<void> rejectFriendRequest(String userId);
  Future<void> removeFriend(String userId);

} 