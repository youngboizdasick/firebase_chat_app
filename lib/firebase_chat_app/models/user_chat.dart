import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_app/firebase_chat_app/constants/firebase_constants.dart';

class UserChat {
  String? id;
  String? photoUrl;
  String? nickname;
  String? aboutMe;
  String? phoneNumber;

  UserChat({this.id, this.photoUrl, this.nickname, this.aboutMe, this.phoneNumber});

  UserChat.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    photoUrl = json['photoUrl'] ?? '';
    nickname = json['nickname'] ?? '';
    aboutMe = json['aboutMe'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
  }

  factory UserChat.fromDocument(DocumentSnapshot doc) {
    String aboutMe = '';
    String photoUrl = '';
    String nickname = '';
    String phoneNumber = '';
    try {
      aboutMe = doc.get(FirebaseConstants.aboutMe);
    } catch (e) {}
    try {
      photoUrl = doc.get(FirebaseConstants.photoUrl);
    } catch (e) {}
    try {
      nickname = doc.get(FirebaseConstants.nickname);
    } catch (e) {}
    try {
      phoneNumber = doc.get(FirebaseConstants.phoneNumber);
    } catch (e) {}
    return UserChat(id: doc.id, phoneNumber: phoneNumber, photoUrl: photoUrl, nickname: nickname, aboutMe: aboutMe);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[FirebaseConstants.id] = id;
    data[FirebaseConstants.photoUrl] = photoUrl;
    data[FirebaseConstants.nickname] = nickname;
    data[FirebaseConstants.aboutMe] = aboutMe;
    data[FirebaseConstants.phoneNumber] = phoneNumber;
    return data;
  }
}
