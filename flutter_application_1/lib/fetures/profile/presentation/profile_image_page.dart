import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:iconsax/iconsax.dart';

class FullScreenImagePage extends StatelessWidget {
  final String profileImage;

  const FullScreenImagePage({super.key, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    final bool hasImage = profileImage.isNotEmpty;

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppPallete.gradient2,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Profile Image"),
      ),
      body: Center(
        child: Hero(
          tag: 'profileImageHero',
          child: hasImage
              ? InteractiveViewer(
                  child: Image.network(
                    profileImage,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => _fallbackIcon(),
                  ),
                )
              : _fallbackIcon(),
        ),
      ),
    );
  }

  Widget _fallbackIcon() {
    return Icon(
      Iconsax.profile_circle,
      size: 120,
      color: Colors.grey[600],
    );
  }
}
