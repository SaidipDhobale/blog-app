import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class AddIcon extends StatelessWidget {
  VoidCallback onPressed;
  IconData name;
  double size;
   AddIcon({super.key,required this.onPressed,required this.name,required this.size});

  @override
  Widget build(BuildContext context) {
    return           Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: onPressed,
                icon:  Icon(name,size: 30,))
          ) ;
  }
}