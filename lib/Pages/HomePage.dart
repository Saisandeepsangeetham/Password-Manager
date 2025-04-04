import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'GeneratorPage.dart';
import 'VaultPage.dart';
import 'SettingsPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          Vaultpage(),
          Generatorpage(),
          Settingspage(),
        ],
        items: _navBarsItems(),
        hideNavigationBarWhenKeyboardShows: true,
        resizeToAvoidBottomInset: true,
        bottomScreenMargin: 0,
        handleAndroidBackButtonPress: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.lock_outline),
        title: "Passwords",
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.generating_tokens_outlined),
        title: "Generator",
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
      ),
    ];
  }
}
