import 'package:flutter/material.dart';

class Toast extends StatelessWidget {
  final String text;
  const Toast({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // So it blends over UI
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style:const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
