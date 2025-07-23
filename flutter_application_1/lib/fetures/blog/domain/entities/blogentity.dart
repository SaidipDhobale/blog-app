import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Blog {
    final String id;
    final DateTime updated_at;
    final String title;
    final String content;
    final String image_url;
    final String userid;
    final List<String> topics;
  Blog({
    required this.id,
    required this.updated_at,
    required this.title,
    required this.content,
    required this.image_url,
    required this.userid,
    required this.topics,
  });
  

  
}
