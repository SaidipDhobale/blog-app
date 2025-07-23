// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';
import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/blog/data/Models/blogmodel.dart';
import 'package:flutter_application_1/fetures/blog/data/datasource/blog_remotesource_data.dart';
import 'package:flutter_application_1/fetures/blog/data/datasource/hivedatasource/hivedata.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';

class BlogRepositoryImp implements BlogRepository {
  BlogDataSourceImp blogDataSourceImp;
HiveDataSourceImp hiveDataSourceImp;
  BlogRepositoryImp({
    required this.blogDataSourceImp,
    required this.hiveDataSourceImp,
  });

  @override
  Future<Either<Failure, Blog>> addBlog(
      {required String title,
      required String content,
      required String userid,
      required String updatedAt,
      required String id,
      required  File image,
      required List<String> topics}) async {
    try {
      log("blog repos$userid");
      final res = await blogDataSourceImp.addBlogImage(id, image);
      final model = await blogDataSourceImp.addToBlog(BlogModel(
          id: id,
          updated_at: DateTime.parse(updatedAt),
          title: title,
          content: content,
          userid: userid,
          topics: topics,
          image_url: res));

     
      final message=await hiveDataSourceImp.putImageInHive(id,image);
      log("image uploaded sucessfully!!!! :$message");

      return right(model);
    } catch (e) {
      log(e.toString());
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> fetchBlock() async{
      try{
        final res=await blogDataSourceImp.fetchBlogs();
        return right(res);
      }catch(e){
        return left(Failure(e.toString()));
      }
      
  }
  
  @override
  Future<Either<Failure, String>> deleteBlock({required String id})async {
      try{
        final res=await blogDataSourceImp.deleteBlog(id);
        await hiveDataSourceImp.deleteImage(id);
        return right(res);
      }catch(e){
        return left(Failure(e.toString()));
      }
  }
  
  @override
  Future<Either<Failure, Blog>> editBlock({required String title,
      required String content,
      required String userid,
      required String updatedAt,
      required String id,
      required  File image,
      required List<String> topics,
      required bool isImageChanged})async {
      try{
        
        if(isImageChanged){
            await blogDataSourceImp.deleteStorageImage(id, image);
           final resimage=await blogDataSourceImp.addBlogImage(id, image);
          final ig=await image.readAsBytes();
          final res=await blogDataSourceImp.editBlog(BlogModel(id: id, updated_at: DateTime.parse(updatedAt), title: title, content: content, image_url: resimage, userid: userid, topics: topics));
          await hiveDataSourceImp.updateImage(id,ig);
          return right(res);
        }else{
          final ig=await blogDataSourceImp.getImageURL(id);
          final res=await blogDataSourceImp.editBlog(BlogModel(id: id, updated_at: DateTime.parse(updatedAt), title: title, content: content, image_url: ig, userid: userid, topics: topics));
          return right(res);
        }
       
        
      }catch(e){
          log("2:${e.toString()}");
          return left(Failure(e.toString()));
      }
  }

   @override
  Future<Either<Failure, List<PostImage>>> getAllImagesFromHive()async {
    try{
        final res=await hiveDataSourceImp.getAllImagesFromHive();
        log("repo of image hive");
        return right(res);
    }catch(e){
        return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Blog>>> fetchMyAllBlog({required String userid})async {
    try{
        final res=await blogDataSourceImp.fetchMyBlogs(userid);
        return right(res);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
  
  

  

  

}
