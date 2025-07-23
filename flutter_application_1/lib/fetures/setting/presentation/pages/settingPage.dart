import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/languages/language.dart';
import 'package:flutter_application_1/core/navbar/mybottomnavbar.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/fetures/setting/presentation/cubit/theme_cubit.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  @override
  Widget build(BuildContext context) {
    final local=AppLocalizations.of(context)!;
    final isDark =
        context.watch<ThemeCubit>().state.themeMode == ThemeMode.dark;
    return Scaffold(
      bottomNavigationBar: const MyBottomNavBar(currentIndex: 1),
      appBar: AppBar(
        backgroundColor: AppPallete.gradient2,
        title:  Text(local.setting),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title:Text(local.darkMode),
            value: isDark,
            onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
          ),
          SelectLanguageWidget(
            selectedLocale: Localizations.localeOf(context),
            onLanguageSelected: (locale) async{
                MainApp.setLocale(context, locale); 
               final prefs = await SharedPreferences.getInstance();
              await prefs.setString('selected_language_code', locale.languageCode);
              
              // Your language-changing logic
            },
          )
        ],
      ),
    );
  }
}
