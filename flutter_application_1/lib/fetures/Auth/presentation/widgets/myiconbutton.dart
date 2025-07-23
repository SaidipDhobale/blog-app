import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageurl;
  const MyIconButton({super.key,required this.onPressed,required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return IconButton(
                      onPressed: onPressed,
                      icon: Opacity(
                        opacity: 0.9,
                        child: Image.asset(
                          imageurl,
                          height: 35,
                          width: 35,
                        ),
                      ),
                      tooltip: "sign in with google",
                    );
  }
}