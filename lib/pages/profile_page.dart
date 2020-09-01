import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';
import '../util/helper.dart';
import '../widgets/game_drawer.dart';

class PlayerProfilePage extends StatefulWidget {
  static String get routeName => '@routes/profile_page';
  @override
  _PlayerProfilePageState createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  dynamic routeArgs;
  final _labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final _valueStyle = TextStyle(fontSize: 15);
  final _defaultItensGap = 20.0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeArgs = ModalRoute.of(context).settings.arguments;
    print('getting route args');
    print(routeArgs);
  }

//TODO: move strings to localiztions
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: api(context).getSurvivor(routeArgs),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              dynamic _profileData = snapshot.data;
              return Column(
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      child: Image.asset('assets/zombie_002.png')),
                  SizedBox(height: _defaultItensGap),
                  Row(children: <Widget>[
                    InkWell(
                      child: Text('VER ITENS'),
                      onTap: () => Navigator.of(context).popAndPushNamed(
                          SurvivorItemsPage.routeName,
                          arguments: routeArgs),
                    )
                  ]),
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Nome',
                              textAlign: TextAlign.start, style: _labelStyle),
                          Text(_profileData['name'] ?? 'Não informado',
                              style: _valueStyle)
                        ]),
                  ),
                  SizedBox(height: _defaultItensGap),
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('sexo', style: _labelStyle),
                          Text(_profileData['gender'] ?? 'Não informado',
                              style: _valueStyle),
                        ]),
                  ),
                  SizedBox(height: _defaultItensGap),
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Idade', style: _labelStyle),
                          Text(
                              _profileData['age'].toString() ?? 'Não informado',
                              style: _valueStyle),
                        ]),
                  ),
                  SizedBox(height: _defaultItensGap),
                  Container(
                    width: MediaQuery.of(context).size.width * .8,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Status', style: _labelStyle),
                          Text(
                              _profileData['infected']
                                  ? 'Infectado'
                                  : 'Saudável',
                              style: _valueStyle)
                        ]),
                  ),
                ],
              );
            }
            return Loading();
          }),
    );
  }
}
