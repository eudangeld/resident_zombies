import 'package:flutter/material.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/game_drawer.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

class AllPLayersPage extends StatefulWidget {
  @override
  _AllPLayersPageState createState() => _AllPLayersPageState();
}

class _AllPLayersPageState extends State<AllPLayersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(child: GameDrawer()),
      body: FutureBuilder(
          future: api(context).getAll(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
            } else {
              return Loading();
            }
          }),
    );
  }
}
