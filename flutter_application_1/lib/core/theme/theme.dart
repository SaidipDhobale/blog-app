import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';

class AppTheme{
    static  _border([Color color=AppPallete.borderColor])=>OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color:color,
          width: 3 ),
    );
    static final darkThemeMode=ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        focusedBorder: _border(AppPallete.gradient2),
      ),
    
    );
}