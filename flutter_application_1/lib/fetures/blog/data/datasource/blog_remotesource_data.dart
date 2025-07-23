// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_1/core/error/Exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_application_1/fetures/blog/data/Models/blogmodel.dart';

abstract interface class BlogRemoteSource {
    Future<BlogModel>addToBlog(BlogModel model);

    Future<String>addBlogImage(String userid,File image);

    Future<List<BlogModel>>fetchBlogs();

    Future<BlogModel>editBlog(BlogModel model);

    Future<String>deleteBlog(String id);

    Future<void>deleteStorageImage(String userid,File image);

    Future<List<BlogModel>>fetchMyBlogs(String userid);
    
}

class BlogDataSourceImp implements BlogRemoteSource {
  SupabaseClient supabaseClient;
  BlogDataSourceImp({
    required this.supabaseClient,
  });
  
  @override
  Future<BlogModel> addToBlog(BlogModel model)async {
      try{
        log("in blog upload data section");
          final res=await supabaseClient.from("blog").insert(model.toJson()).select();
          log("${model.toString()}");
          if(res.isEmpty){
            log("empty result");
              throw ServerException(message: "error occured");
          }
          log("${res.first}");
          return BlogModel.fromMap(res.first);
      } catch (e){
        log(e.toString());
          throw e.toString();
      }
  }
  
  @override
  Future<String> addBlogImage(String blogid, File image)async {
   try{
    final res = await supabaseClient.storage//
    .from('blog_images') // 👈 your bucket name
    .upload(blogid, image,fileOptions: const FileOptions(
      upsert: true,         // ✅ allow overwriting
    ),);
    return supabaseClient.storage
    .from('blog_images')
    .getPublicUrl(blogid);
   }catch(e){
    log(e.toString());
    throw ServerException(message: e.toString());
   }
  }
  
 @override
  Future<List<BlogModel>> fetchBlogs() async {
    try{

      final res = await supabaseClient.from('blog').select();
      return (res as List<dynamic>)
        .map((item) => BlogModel.fromMap(item))
        .toList();

    }catch(e){
      throw ServerException(message: "error while fetching");
    }
  }
  
  @override
  Future<String> deleteBlog(String id)async {
      try{
          final response = await supabaseClient
      .from('blog') 
      .delete()
      .eq('id', id) ;
      
        log("1:sucess");
          return "sucess";
      }catch(e){
         log(e.toString());
          throw ServerException(message: e.toString());
      }
      

  }
  
  @override
  Future<BlogModel> editBlog(BlogModel model)async {
    try{  
      final res=await supabaseClient.from("blog").update(model.toJson()).eq('id', model.id);
      log("in edit data source");
      return model.copyWith();
    }catch(e){
      log(e.toString());
      throw ServerException(message: e.toString());
    }

  }
  
  @override
  Future<void> deleteStorageImage(String blogid, File image)async {
    log("blogid:--$blogid");
    
      final res=await supabaseClient.storage.from('blog_images').remove([blogid]);
      
      log("delete:-$res");
  }

  Future<String> getImageURL(String blogid)async{
    try{
        return  supabaseClient.storage
    .from('blog_images')
    .getPublicUrl(blogid);
    }catch(e){
        throw ServerException(message: e.toString());
    }
  }
  
 @override
Future<List<BlogModel>> fetchMyBlogs(String userId) async {
  try {
  final response = await supabaseClient
      .from('blog')
      .select('*')
      .eq('userid', userId)
      .order('updated_at', ascending: false);

  return response.map((row) => BlogModel.fromMap(row)).toList();
} catch (e) {
  // Handle SupabaseException, network issues, etc.
  throw ServerException(message: 'Failed to fetch blogs: $e');
}
}

}
