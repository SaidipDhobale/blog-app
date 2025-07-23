

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';

import 'package:fpdart/fpdart.dart';
abstract interface class HiveImageRepo{
  Future<Either<Failure,List<PostImage>>> getAllImagesFromHive();

  
}