import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onpressed;
  const AuthGradientButton(
      {super.key, required this.buttonText, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2]),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: const Size(395, 55),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
