// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_application_1/fetures/profile/data/model/profile_model.dart';
import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/profile/data/datasource/supabase_profile.dart';
import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/domain/repository/profile_repository_interface.dart';

class ProfileRepositoryImp extends ProfileRepository {

ProfileDataSourceImp profileDataSourceImp;
  ProfileRepositoryImp({
    required this.profileDataSourceImp,
  });

  
  
  @override
  Future<Either<Failure, Profile>> getProfileData(String id)async {
    try{
        final res=await profileDataSourceImp.getProfileData(id);
        return right(res);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Profile>> editProfileData({required String name, required String email, required File imageurl, required int mobileno,required String userid,required bool isImageChanged,required String imagenetwork})async {
    try{
      if(isImageChanged){
        await profileDataSourceImp.deleteProfileImage(userid);
        final image=await profileDataSourceImp.addProfileImage(userid, imageurl);
        final res=await profileDataSourceImp.editProfileData(ProfileModel(id: userid, name: name, email: email, profileImage: image, mobileNo: mobileno));
        return right(res);
      }else{
        
        final res=await profileDataSourceImp.editProfileData(ProfileModel(id: userid, name: name, email: email, profileImage: imagenetwork, mobileNo: mobileno));
        return right(res);
      }
      
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

}
