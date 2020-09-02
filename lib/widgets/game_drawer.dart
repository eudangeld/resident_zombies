import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/all_players_page.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/pages/profile_page.dart';
import 'package:resident_zombies/util/helper.dart';

class GameDrawer extends StatefulWidget {
  @override
  _GameDrawerState createState() => _GameDrawerState();
}

class _GameDrawerState extends State<GameDrawer> {
  List<DrawerItem> drawerItems;

  @override
  void initState() {
    super.initState();
    drawerItems = [
      DrawerItem(
          label: lz(context).drawerProfile, route: PlayerProfilePage.routeName),
      DrawerItem(label: lz(context).drawereMap, route: MaingamePage.routeName),
      DrawerItem(
          label: lz(context).drawerItens, route: PlayerProfilePage.routeName),
      DrawerItem(label: lz(context).drawerFriends),
      DrawerItem(
          label: lz(context).drawerAllPlayers, route: AllPLayersPage.routeName),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: drawerItems.length,
        itemBuilder: (context, index) => ListTile(
              onTap: drawerItems[index].route != null
                  ? Navigator.of(context).pushNamed(drawerItems[index].route)
                  : '',
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
