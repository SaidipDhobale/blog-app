import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';

class RichTexts extends StatelessWidget {
  final String text;
  const RichTexts({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account ?",style: TextStyle(color: AppPallete.whiteColor),),
        GestureDetector(
          onTap: (){},
          child: Text(text,style: const TextStyle(color: AppPallete.gradient1),)),
      ],
    );
     
  }
}