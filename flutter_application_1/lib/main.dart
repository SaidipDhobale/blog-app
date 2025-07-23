import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/navbar/bloc/navbar_bloc.dart';
import 'package:flutter_application_1/core/notifications/message.dart';
import 'package:flutter_application_1/core/notifications/notification_service.dart';
import 'package:flutter_application_1/core/theme/theme.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/dependency.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/pages/login_page.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/cubit/currentblog_cubit.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/blog_page.dart';
import 'package:flutter_application_1/fetures/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application_1/fetures/setting/presentation/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Make sure Firebase is initialized
  await Firebase.initializeApp(options:const FirebaseOptions(apiKey: "AIzaSyBeamKJcHVeBjYusBPBuVbuBvQFK8tBCDY", appId:"1:145913358628:android:e2bc5bcf5cfe461f7d2bb1", messagingSenderId: "145913358628", projectId: "blogmessage"));

  // Now it's safe to use
  log("✅ Background Message: ${message.notification?.title}");
}
final GlobalKey<NavigatorState> navigatorkey=GlobalKey();
String ?fCMToken;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   final prefs = await SharedPreferences.getInstance();
  final savedCode = prefs.getString('selected_language_code') ?? 'en';
  final isDark = prefs.getBool('is_dark_mode') ?? false;
  await Firebase.initializeApp(options:const FirebaseOptions(apiKey: "AIzaSyBeamKJcHVeBjYusBPBuVbuBvQFK8tBCDY", appId:"1:145913358628:android:e2bc5bcf5cfe461f7d2bb1", messagingSenderId: "145913358628", projectId: "blogmessage"));
   fCMToken=await initialCloudMessaging();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    PushNotifications.isDark=isDark;
    PushNotifications.savedCode=savedCode;
    PushNotifications.init();
  PushNotifications.localNotiInit();
  final message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
      Future.delayed(const Duration(seconds: 1), () {
        // navigatorkey.currentState!.pushNamed("/message", arguments: message);
         MainApp(initialThemeMode: isDark ? ThemeMode.dark : ThemeMode.light,initialLocale: Locale(savedCode),);
      });
  }//background messaging
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox<Uint8List>('postImages');
  await initalAuth();
  await initalBlog();
  await initalProfile();

  

  // one box for all post‑images

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) {
      return ThemeCubit(themeMode:isDark ? ThemeMode.dark : ThemeMode.light);
    }),
    BlocProvider(create: (_) {
      return serviceLocator<ProfileBloc>();
    }),
    BlocProvider(create: (_) {
      return serviceLocator<NavbarBloc>();
    }),
    BlocProvider(create: (_) {
      return serviceLocator<BlogBloc>();
    }),
    BlocProvider(create: (context) {
      return serviceLocator<UserCubit>();
    }),
    BlocProvider(create: (context) {
      return serviceLocator<AuthBloc>();
    }),
    BlocProvider(create: (context) {
      return serviceLocator<CurrentblogCubit>();
    })
  ], child: MainApp(initialThemeMode:isDark ? ThemeMode.dark : ThemeMode.light,initialLocale: Locale(savedCode),)));
}

class MainApp extends StatefulWidget {
  final Locale initialLocale;
  final ThemeMode initialThemeMode;
  const MainApp({required this.initialThemeMode,required this.initialLocale,super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
   // Default
    late Locale _locale = widget.initialLocale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates:const[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ] ,
          locale: _locale,
          supportedLocales: const[
            Locale('en'),
            Locale('hi'),
            Locale('mr')
          ],
          navigatorKey: navigatorkey,
      routes: {
        
        "/message": (context) => const Message()
      },
            darkTheme: AppTheme.darkThemeMode,
            theme: ThemeData.light().copyWith(
              inputDecorationTheme:const InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            home: BlocSelector<UserCubit, UserState, bool>(
              selector: (state) {
                return state is UserLoggedIn;
              },
              builder: (context, state) {
                if (state) {
                  return const MyBlog();
                }
                return const LoginPage();
              },
            ));
      },
    );
  }
}
