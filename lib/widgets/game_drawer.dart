import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/all_players_page.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/pages/profile_page.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
import 'package:resident_zombies/util/helper.dart';

class GameDrawer extends StatefulWidget {
  @override
  _GameDrawerState createState() => _GameDrawerState();
}

class _GameDrawerState extends State<GameDrawer> {
  List<DrawerItem> drawerItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    drawerItems = [
      DrawerItem(
          label: lz(context).drawerProfile, route: PlayerProfilePage.routeName),
      DrawerItem(label: lz(context).drawereMap, route: MainGamePage.routeName),
      DrawerItem(
          label: lz(context).drawerItens, route: SurvivorItemsPage.routeName),
      // DrawerItem(label: lz(context).drawerFriends),
      DrawerItem(
          label: lz(context).drawerAllPlayers, route: AllPLayersPage.routeName),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: drawerItems.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () => Navigator.of(context).pushNamed(
                  drawerItems[index].route ?? MainGamePage.routeName),
              title: Text(drawerItems[index].label),
            ));
  }
}

class DrawerItem {
  final String label;
  final String route;

  DrawerItem({
    this.label,
    this.route,
  });
}
