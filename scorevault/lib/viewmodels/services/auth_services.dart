import 'package:scorevault/Models/model_user.dart';

// con dart, la definizione di interfacce è implicita quando si creano classi astratte.
abstract class AuthServices {

  // gestione CRUD utente e autenticazione
  Future<void> signin(String email, String password);
  Future<void> signup(String email, String password, String username);
  Future<void> signout();
  Future<void> deleteUser();
  Stream<ModelUser> fetchUserData();
  Stream<List<ModelUser>> getAllUsersExceptCurrentUserAndFriendsAndPending();

  // gestione notifiche amicizie
  Future<void> sendFriendRequest(String userId);
  Stream<List<ModelUser>> getFriendsRequests();
  Stream<List<ModelUser>> getFriendsList();
  Future<void> acceptFriendRequest(String userId);
  Future<void> rejectFriendRequest(String userId);
  Future<void> removeFriend(String userId);

} 