import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/navbar/bloc/navbar_bloc.dart';
import 'package:flutter_application_1/core/navbar/navbar.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/blog_page.dart';
import 'package:flutter_application_1/fetures/blog/presentation/pages/myblogs.dart';
import 'package:flutter_application_1/fetures/profile/presentation/profilepage.dart';
import 'package:flutter_application_1/fetures/setting/presentation/pages/settingPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Navigator keys (one per tab) */
// final _homeKey     = GlobalKey<NavigatorState>();
// final _profileKey  = GlobalKey<NavigatorState>();
// final _settingsKey = GlobalKey<NavigatorState>();
// final _logoutKey   = GlobalKey<NavigatorState>();

class _TabNavigator extends StatelessWidget {
  final Widget root;
  final GlobalKey<NavigatorState> navigatorKey;

  const _TabNavigator({
    required this.navigatorKey,
    required this.root,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => root),
    );
  }
}


class RootScreen extends StatefulWidget {
 
  RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
   final _homeKey     = GlobalKey<NavigatorState>();
  final _profileKey  = GlobalKey<NavigatorState>();
  final _settingsKey = GlobalKey<NavigatorState>();
  final _myBlogKey   = GlobalKey<NavigatorState>();
  late final List<Widget> _tabs;
  @override
  void initState() {
    
    super.initState();
     _tabs = <Widget>[
    _TabNavigator(navigatorKey: _homeKey,     root: const MyBlog()),
    _TabNavigator(navigatorKey: _profileKey,  root: const ProfilePage(),),
    _TabNavigator(navigatorKey: _settingsKey, root:const Settingpage(),),
    _TabNavigator(navigatorKey: _myBlogKey,   root: const MyBlogs()),
  ];
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(
      builder: (_, state) {
        final current = state.index;

        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) return;
            final bloc   = context.read<NavbarBloc>();
            final navKey = [_homeKey, _profileKey, _settingsKey, _myBlogKey][current];
            final popped = await navKey.currentState!.maybePop();

            if (!context.mounted) return;
            if (popped)       return;           // inner page popped
            if (current != 0) {bloc.add(NavigationTabChanged(0));}
            else{Navigator.of(context).maybePop();} // exit app
          },
          child: Scaffold(
            body: SafeArea(
              bottom: true,
              child: IndexedStack(index: current, children: _tabs)),
            bottomNavigationBar: const MyNavigationBar()
          ),
        );
      },
    );
  }
}
