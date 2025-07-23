import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract  class HivedataSource{
    Future<String> putImageInHive(String postid,File file);

    Future<List<PostImage>> getAllImagesFromHive();

}

class HiveDataSourceImp extends HivedataSource{

  Box box ;

  HiveDataSourceImp({required this.box});
  @override
  Future<List<PostImage>> getAllImagesFromHive() async {
  
  try{

      final List<PostImage> images = [];

  for (var key in box.keys) {
    if (key is String) {
      final Uint8List? bytes = box.get(key);
      if (bytes != null) {
        images.add(PostImage(postId: key, imageBytes: bytes));
      }
    }
  }

  log("get all images data source:-");

  return images;
  }catch(e){
      throw ServerException(message: e.toString());
  }
}

  @override
  Future<String> putImageInHive(String postid, File file)async {
    
    // skip if already cached
   try{

     if (box.containsKey(postid)) return "sucess";

    //final resp = await http.get(Uri.parse(url));
    final Uint8List bytes = await file.readAsBytes();
    // if (resp.statusCode == 200) {
    //   await box.put(postid, resp.bodyBytes);
      
    // }else{
    //   throw ServerException(message: resp.statusCode.toString());
    // }
    await box.put(postid, bytes);
    log("upload imaage data source");
    return "sucess";

   }catch(e){
        throw ServerException(message: e.toString());
   }
  }
    
   Future<void> deleteImage(String postId) async {
  if (box.containsKey(postId)) {
    await box.delete(postId);
    log('Image with postId $postId deleted.');
  } else {
    log('No image found for postId $postId.');
  }
}

Future<void> updateImage(String postId, Uint8List newImageBytes) async {
  await box.put(postId, newImageBytes); // overwrites if exists
  log('Image with postId $postId updated.');
}
  
}