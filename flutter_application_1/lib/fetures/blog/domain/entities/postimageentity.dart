import 'dart:typed_data';

class PostImageEntity {
  final String postId;
  final Uint8List imageBytes;

  PostImageEntity({required this.postId, required this.imageBytes});
}