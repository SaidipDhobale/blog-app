import 'dart:io';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> addBlog({
    required String title,
    required String content,
    required String userid,
    required String updatedAt,
    required String id,
    required File image,
    required List<String> topics,
  });

  Future<Either<Failure, List<Blog>>> fetchBlock();
  Future<Either<Failure, List<Blog>>> fetchMyAllBlog({required String userid});
  Future<Either<Failure, Blog>> editBlock({
    required String title,
    required String content,
    required String userid,
    required String updatedAt,
    required String id,
    required File image,
    required List<String> topics,
    required bool isImageChanged,
  });

  Future<Either<Failure, String>> deleteBlock({required String id});

  Future<Either<Failure,List<PostImage>>> getAllImagesFromHive();
  
}
