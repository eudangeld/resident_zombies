import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/all_players_page.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/pages/profile_page.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
import 'package:resident_zombies/theme/global_theme.dart';
import 'package:resident_zombies/util/helper.dart';

class GameDrawer extends StatefulWidget {
  @override
  _GameDrawerState createState() => _GameDrawerState();
}

class _GameDrawerState extends State<GameDrawer> {
  List<DrawerItem> drawerItems;

  final _drawerItemStyle =
      TextStyle(color: heavyDark, fontSize: 17, fontWeight: FontWeight.w400);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    drawerItems = [
      DrawerItem(
          label: lz(context).drawereMap,
          icon: Icon(
            Icons.map,
            color: heavyDark,
          ),
          route: MainGamePage.routeName),
      DrawerItem(
          icon: Icon(
            Icons.build,
            color: heavyDark,
          ),
          label: lz(context).drawerItens,
          route: SurvivorItemsPage.routeName),
      // DrawerItem(label: lz(context).drawerFriends),
      DrawerItem(
          icon: Icon(
            Icons.people,
            color: heavyDark,
          ),
          label: lz(context).drawerAllPlayers,
          route: AllPLayersPage.routeName),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: Text('Resident zombie',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: heavyDark)),
        ),
        DrawerProfileWidget(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: drawerItems.length,
          itemBuilder: (context, index) => ListTile(
            leading: drawerItems[index].icon,
            onTap: () => Navigator.of(context).popAndPushNamed(
                drawerItems[index].route ?? MainGamePage.routeName),
            title: Text(
              drawerItems[index].label,
              style: _drawerItemStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class DrawerProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).popAndPushNamed(PlayerProfilePage.routeName),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(child: Image.asset(reselvePlyerAsset(context)))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(user(context).name,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: heavyDark)),
                Text('Idade:' + user(context).age.toString()),
                Text('Gênero:' + user(context).gender),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerItem {
  final String label;
  final String route;
  final Icon icon;

  DrawerItem({
    this.label,
    this.icon,
    this.route,
  });
}
