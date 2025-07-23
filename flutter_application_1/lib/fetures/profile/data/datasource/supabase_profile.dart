import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_1/core/error/Exceptions.dart';
import 'package:flutter_application_1/fetures/profile/data/model/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileDataSource{

    Future<ProfileModel> getProfileData(String id);
    Future<ProfileModel> editProfileData(ProfileModel model);
    Future<String>addProfileImage(String id,File file);
    Future<String>deleteProfileImage(String id);
    
} 

class ProfileDataSourceImp extends ProfileDataSource{

  SupabaseClient supabaseClient;
  ProfileDataSourceImp({required this.supabaseClient});
  @override
  Future<ProfileModel> editProfileData(ProfileModel model)async {
   try{  
      await supabaseClient.from("profiles").update(model.toMap()).eq('id', model.id);
      log("in edit data source");
      return model.copyWith();
    }catch(e){
      log(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel> getProfileData(String id) async{
        try{
              log("id:--$id");
              final res=await supabaseClient.from("profiles").select().eq('id',id).single();
              log(ProfileModel.fromMap(res).toString());
              return ProfileModel.fromMap(res);
        }catch(e){
            throw ServerException(message: e.toString());
        }
  }
   @override
  Future<String> addProfileImage(String id, File image)async {
   try{
    final res = await supabaseClient.storage//
    .from('blog_images') // 👈 your bucket name
    .upload(id, image,fileOptions: const FileOptions(
      upsert: true,         // ✅ allow overwriting
    ),);
    log("addimage");
    return supabaseClient.storage
    .from('blog_images')
    .getPublicUrl(id);
   }catch(e){
    log(e.toString());
    throw ServerException(message: e.toString());
   }
  }
   @override
  Future<String> deleteProfileImage(String id)async {
      try{
        log("deleted");
         final res=await supabaseClient.storage.from('blog_images').remove([id]);
      
        log("1:sucess");
          return "sucess";
      }catch(e){
         log(e.toString());
          throw ServerException(message: e.toString());
      }
      

  }



}