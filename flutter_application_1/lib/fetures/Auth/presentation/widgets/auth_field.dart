import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final hintext;
  final TextEditingController controller;
  const AuthField({super.key,required this.hintext,required this.controller});

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
    );
  }
}