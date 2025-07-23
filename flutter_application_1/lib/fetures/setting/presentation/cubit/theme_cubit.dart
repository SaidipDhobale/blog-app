import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeMode themeMode}) : super( ThemeState(themeMode:themeMode ));

  void toggleTheme()async {
    // final isDark = state.themeMode == ThemeMode.dark;
    // emit(ThemeState(themeMode: isDark ? ThemeMode.light : ThemeMode.dark));
    final prefs = await SharedPreferences.getInstance();

    if (state.themeMode == ThemeMode.dark) {
      emit(const ThemeState(themeMode:ThemeMode.light));
      await prefs.setBool('is_dark_mode', false);
    } else {
      emit(const ThemeState(themeMode:ThemeMode.dark));
      await prefs.setBool('is_dark_mode', true);
    }
  }
}
