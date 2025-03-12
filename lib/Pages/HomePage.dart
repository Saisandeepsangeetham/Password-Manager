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
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          Vaultpage(),
          Generatorpage(),
          Settingspage(),
        ],
        items: _navBarsItems(),
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
          icon: Icon(Icons.generating_tokens_outlined), title: "Generator"),
      PersistentBottomNavBarItem(icon: Icon(Icons.settings), title: "Settings"),
    ];
  }
}
