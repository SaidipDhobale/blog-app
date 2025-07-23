import 'dart:io';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract  class ProfileRepository{
      Future<Either<Failure,Profile>> getProfileData(String id);

      Future<Either<Failure,Profile>>editProfileData({required String name,required String email,required File imageurl,required int mobileno,required String userid, required bool isImageChanged,required String imagenetwork});

}