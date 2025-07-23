import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';

class BlogModel extends Blog {
  BlogModel({required super.id, required super.updated_at, required super.title, required super.content, required super.image_url, required super.userid, required super.topics});
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updated_at.toIso8601String(),
      'title': title,
      'content': content,
      'image_url': image_url,
      'userid': userid,
      'topics': topics,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      updated_at:map['updated_at']==null ?DateTime.now(): DateTime.parse(map['updated_at']),
      title: map['title'] as String,
      content: map['content'] as String,
      image_url: map['image_url'] as String,
      userid: map['userid'] as String,
      topics: List<String>.from((map['topics'] as List),
    ));

  }

 BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? title,
    String? content,
    String? imageUrl,
    String? userid,
    List<String>? topics,
  }) {
    return BlogModel(
      id: id ?? this.id,
      updated_at: updatedAt ?? updated_at,
      title: title ?? this.title,
      content: content ?? this.content,
      image_url: imageUrl ?? image_url,
      userid: userid ?? this.userid,
      topics: topics ?? List<String>.from(this.topics),
    );
  }
  
  @override
  String toString() {
    return 'BlogModel(id: $id, updated_at: $updated_at, title: $title, content: $content, image_url: $image_url, userid: $userid, topics: $topics)';
  }
}