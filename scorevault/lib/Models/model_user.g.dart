// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUser _$ModelUserFromJson(Map<String, dynamic> json) => ModelUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  friendsList:
      (json['friendsList'] as List<dynamic>).map((e) => e as String).toList(),
  pendingFriendsList:
      (json['pendingFriendsList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  username: json['username'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$ModelUserToJson(ModelUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'username': instance.username,
  'friendsList': instance.friendsList,
  'pendingFriendsList': instance.pendingFriendsList,
  'profileImageUrl': instance.profileImageUrl,
};
