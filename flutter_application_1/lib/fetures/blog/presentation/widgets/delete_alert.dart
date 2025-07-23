import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDeleteDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
     final local=AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_amber_rounded,
                size: 60, color: Colors.redAccent),
            const SizedBox(height: 15),
             Text(
              local.areYouSure,
              style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
             Text(
             local.areYouSure,
              textAlign: TextAlign.center,
              style:const TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    child: Text(local.cancel),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete_forever),
                    label:Text(local.delete),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: onConfirm,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
