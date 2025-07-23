import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final VoidCallback onConfirm;
  final String? cancelText;
  final VoidCallback? onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:AppPallete.backgroundColor ,
      shape: RoundedRectangleBorder(

        side: const BorderSide(color: AppPallete.whiteColor),
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppPallete.errorColor,
          fontWeight: FontWeight.bold),
      ),
      content: Text(message,style: const TextStyle(color: AppPallete.whiteColor),),
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: onCancel ?? () => Navigator.pop(context),
            child: Text(
              cancelText!,
              style: const TextStyle(color:AppPallete.errorColor),
            ),
          ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor:AppPallete.gradient1,
            shape: RoundedRectangleBorder(
              side:const BorderSide(color: AppPallete.gradient1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
