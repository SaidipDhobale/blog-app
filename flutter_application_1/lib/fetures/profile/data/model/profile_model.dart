// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';

class ProfileModel extends Profile{
 

  ProfileModel({
    required super.id,
    required super.name,
    required super.email,
    required super.profileImage,
    required super.mobileNo,
  }) ;

  // Optional: Convert to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profileimage': profileImage,
      'mobileno': mobileNo,
    };
  }

  // Optional: Create from Map
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id:map['id']??"",
      name: map['name'] ??"",
      email: map['email'] ??"",
      profileImage: map['profileimage'] ??"",
      mobileNo: map['mobileno'] ?? 0,
    );
  }

  ProfileModel copyWith({
    String ?id,
    String? name,
    String? email,
    String? profileImage,
    int? mobileNo,
  }) {
    return ProfileModel(
      id:id??this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      mobileNo: mobileNo ?? this.mobileNo,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(name: $name, email: $email, profileImage: $profileImage, mobileNo: $mobileNo)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.profileImage == profileImage &&
      other.mobileNo == mobileNo;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      mobileNo.hashCode;
  }
}
