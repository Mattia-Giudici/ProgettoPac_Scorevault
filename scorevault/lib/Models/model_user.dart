//TODO classe tutta da ampliare e completare, solo essenziale per ora
import 'package:json_annotation/json_annotation.dart';

part 'model_user.g.dart';

@JsonSerializable()

class ModelUser {
  String uid;
  String email;
  String username;
  List<String> friendsList;
  List<String> pendingFriendsList;
  String? profileImageUrl;

  ModelUser({
    required this.uid,
    required this.email,
    required this.friendsList,
    required this.pendingFriendsList,
    required this.username,
    required this.profileImageUrl,
  });

  String get getUid => uid;
  String get getEmail => email;
  String get getUsername => username;
  List<String> get getFriendsList => friendsList;
  List<String> get getPendingFriendsList => pendingFriendsList;
  String? get getProfileImageUrl => profileImageUrl;

  void setUid(String newUid) {
    uid = newUid;
  }


  void setEmail(String newEmail) {
    email = newEmail;
  }

  void  setUsername(String newUsername) {
    username = newUsername;
  }

  void  setFriendsList(List<String> newFriendsList) {
    friendsList = newFriendsList;
  }

  void  setPendingFriendsList(List<String> newPendingFriendsList) {
    pendingFriendsList = newPendingFriendsList;
  }

  void  setProfileImageUrl(String newProfileImageUrl) {
    profileImageUrl = newProfileImageUrl;
  }

 /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory ModelUser.fromJson(Map<String, dynamic> json) => _$ModelUserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ModelUserToJson(this);



}
