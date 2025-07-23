// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatelessWidget {
  TextEditingController controller;
  String hintext;

   MyTextField({
    super.key,
    required this.controller,
    required this.hintext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value==null || value.isEmpty){
          return 'empty field';
        }
        return null;
      },
      controller: controller,
        decoration: InputDecoration(
          hintText: hintext,
          
        ),
        maxLines: null,
    );
  }
}
