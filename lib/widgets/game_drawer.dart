import 'package:flutter/material.dart';

class GameDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: drawerItems.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(drawerItems[index].label),
            ));
  }
}

final List<DrawerItem> drawerItems = [
  DrawerItem(label: 'Perfil'),
  DrawerItem(label: 'Amigos'),
  DrawerItem(label: 'Todos jogadores'),
];

class DrawerItem {
  final String label;
  final String route;

  DrawerItem({
    this.label,
    this.route,
  });
}
