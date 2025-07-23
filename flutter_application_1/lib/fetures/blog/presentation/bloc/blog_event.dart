part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}


class BlogUploadEvent extends BlogEvent{
    
  final String id;
  final String title;
  final String content;
  final String userid;
  final String updatedAt;
  final List<String> topics;
  final File image;
  BlogUploadEvent({
    required this.id,
    required this.title,
    required this.content,
    required this.userid,
    required this.updatedAt,
    required this.topics,
    required this.image,
  });
}

class FetchBlogEvent extends BlogEvent{
  
}

class EditBlogEvent extends BlogEvent{
  final String id;
  final String title;
  final String content;
  final String userid;
  final String updatedAt;
  final List<String> topics;
  final File image;
  final bool isImageChanged;
  EditBlogEvent({
    required this.id,
    required this.title,
    required this.content,
    required this.userid,
    required this.updatedAt,
    required this.topics,
    required this.image,
    required this.isImageChanged,
  });
}

class DeleteBlogEvent extends BlogEvent{
   final String id;
  DeleteBlogEvent({required this.id});
}

class GetHiveImagesEvent extends BlogEvent{}

class FetchMyBlogEvent extends BlogEvent{
  final String userid;
  FetchMyBlogEvent({required this.userid});
}