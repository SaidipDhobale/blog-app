part of 'blog_bloc.dart';


sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState{

}

final class BlogUploadSucess extends BlogState{
    
}

final class BlogUploadFailure extends BlogState{
    
}
final class BlogFetchSucess extends BlogState{
    List<Blog> bloglist;
    BlogFetchSucess({required this.bloglist});

}

final class BlogEditSucess extends BlogState{
  
}

final class DeleteBlogSucess extends BlogState{

}

final class BlogDeleteFailure extends BlogState{
    
}

final class HiveImageFetchSucess extends BlogState{
    List<PostImageEntity> postimages;
    HiveImageFetchSucess({required this.postimages});

}

final class MyBlogFetchSucess extends BlogState{
    List<Blog> mybloglist;
    MyBlogFetchSucess({required this.mybloglist});

}