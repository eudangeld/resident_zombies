import 'package:flutter/material.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:resident_zombies/pages/profile_page.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/game_drawer.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

class AllPLayersPage extends StatefulWidget {
  static String get routeName => '@routes/all_players_page';
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
              List<dynamic> _data = snapshot.data as List<dynamic>;
              return ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () async => await Navigator.of(context).pushNamed(
                      PlayerProfilePage.routeName,
                      arguments: getIdFromLocation(_data[index]['location'])),
                  title: Text(_data[index]['name']),
                  trailing: Text(_data[index]['gender'] ?? ''),
                  leading: Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset('assets/zombie_002.png')),
                ),
              );
            }
            return Loading();
          }),
    );
  }
}

class PlayerTile extends StatelessWidget {
  final User user;
  const PlayerTile({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(child: Image.asset('assets/zombie_002.png')),
          Column(
            children: <Widget>[
              Text(user.name) ?? 'Name not found',
              Text(user.age.toString() ?? 'Age not found'),
            ],
          )
        ],
      ),
    );
  }
}
