// my_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/navbar/bloc/navbar_bloc.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
   final local= AppLocalizations.of(context)!;
   final current = context.select((NavbarBloc bloc) => bloc.state.index);
    return NavigationBar(
      height: 70,
      elevation: 10,
      indicatorColor: AppPallete.gradient2,
      
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      selectedIndex: current,
      onDestinationSelected: (i) =>
          context.read<NavbarBloc>().add(NavigationTabChanged(i)),
      destinations: [
        NavigationDestination(icon: const Icon(Iconsax.home), label:local.home ),
        NavigationDestination(icon: const Icon(Iconsax.profile_circle), label: local.profile),
        NavigationDestination(icon: const Icon(Iconsax.setting_2), label: local.setting),
        NavigationDestination(icon: const Icon(Iconsax.document), label: local.myBlog),
      ],
    );
  }
}
