

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/blog_page.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/myblogs.dart';
import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/presentation/profilepage.dart';
import 'package:flutter_application_1/fetures/setting/presentation/pages/settingPage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const MyBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyBlog()));
        break;
      // case 1:
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilePage ()));
      //   break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  const Settingpage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  const MyBlogs()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
     final local= AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onTap(context, index),
          backgroundColor: Colors.white,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPallete.gradient2,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items:  [
            BottomNavigationBarItem(
              icon:const Icon(Iconsax.home),
              activeIcon:const Icon(Iconsax.home),
              label: local.home,
            ),
            // BottomNavigationBarItem(
            //   icon:const Icon(Iconsax.profile_circle),
            //   activeIcon:const Icon(Icons.person),
            //   label: 'Profile',
            // ),
            BottomNavigationBarItem(
              icon:const Icon(Iconsax.setting),
              activeIcon:const Icon(Iconsax.settings),
              label: local.setting,
            ),
            BottomNavigationBarItem(
              icon:const Icon(Iconsax.document),
              activeIcon:const Icon(Iconsax.activity),
              label: local.myBlog,
            ),
          ],
        ),
      ),
    );
  }
}
