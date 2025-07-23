import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/fetures/blog/domain/entities/blogentity.dart';

Widget imagePreview(File ?image,Blog? blog) {
    if (image != null) {
      return Image.file(image!, fit: BoxFit.cover);
    } else if (blog != null && blog!.image_url.isNotEmpty) {
      return Image.network(blog!.image_url, fit: BoxFit.cover);
    } else {
      return DottedBorder(
        dashPattern: const [6, 3],
        strokeWidth: 1.5,
        color: Colors.grey,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: const SizedBox(
          height: 150,
          width: double.infinity,
          child: Center(
            child: Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.grey),
          ),
        ),
      );
    }
  }
