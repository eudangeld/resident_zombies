import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
import 'package:resident_zombies/theme/global_theme.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

import '../util/helper.dart';

class PlayerProfilePage extends StatefulWidget {
  static String get routeName => '@routes/profile_page';
  @override
  _PlayerProfilePageState createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  dynamic routeArgs;

  //TODO: move styles to theme and rename it
  final _labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final _valueStyle = TextStyle(fontSize: 15);
  final _nameStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  final _actionTextStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  final _defaultItensGap = 15.0;

  /// Actions buttons values
  ///
  // Used on Material button elevation
  final _defaultElevationValues = 1.0;
  // minbox height used to manting a good layout on button actions
  final _minButtonHeight = 70.0;

  ///[true] if data is from current player
  /// add specifc styles and logic like no trade with me :(
  bool _playerProfile = false;

  /// Get [id] from routeArgments and call userData
  ///
  /// If [id] is null use player [id] itself
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeArgs = ModalRoute.of(context).settings.arguments ??
        state(context).user.value.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: FutureBuilder(
          future: api(context).getSurvivor(routeArgs),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              dynamic _profileData = snapshot.data;
              _playerProfile =
                  _profileData['id'] == state(context).user.value.id;
              print(_profileData['id']);
              return Column(
                children: <Widget>[
                  SizedBox(height: _defaultItensGap),
                  Container(
                      width: MediaQuery.of(context).size.width * .40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(color: Colors.white, width: 10.0)),
                      child: Image.asset('assets/zombie_002.png',
                          fit: BoxFit.fill)),
                  SizedBox(height: _defaultItensGap),
                  Text(_profileData['name'] ?? lz(context).profileUnknowValue,
                      style: _nameStyle),

                  /// you know when u are seeing your profile
                  /// add an (you) above name
                  ///TODO:MOVE YOU TO LOCALIZATIONS
                  _profileData['id'] == state(context).user.value.id
                      ? Text(
                          '(você)',
                          style: _nameStyle.copyWith(
                              fontWeight: FontWeight.normal),
                        )
                      : Container(),

                  /// I dont know how health works
                  // HealthBar(),

                  SizedBox(height: 35),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(lz(context).profileGender,
                                  style: _labelStyle),
                              Text(
                                  _profileData['gender'] ??
                                      lz(context).profileUnknowValue,
                                  style: _valueStyle),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(lz(context).profileAge, style: _labelStyle),
                              Text(
                                  _profileData['age'].toString() ??
                                      lz(context).profileUnknowValue,
                                  style: _valueStyle),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(lz(context).profileStatusTitle,
                                  style: _labelStyle),
                              Text(
                                  _profileData['infected']
                                      ? lz(context).profileStatusYes
                                      : lz(context).profileStatusNo,
                                  style: _valueStyle)
                            ]),
                      ),
                    ],
                  ),

                  SizedBox(height: 35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(color: heavyDark),
                  ),
                  SizedBox(height: 35),

                  /// SCREEN ACTIONS
                  ///
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: _minButtonHeight),
                          child: MaterialButton(
                              elevation: _defaultElevationValues,
                              color: heavyDark,
                              child: Text(lz(context).profileSeeitens,
                                  style: _actionTextStyle,
                                  textAlign: TextAlign.center),
                              onPressed: () => Navigator.of(context).pushNamed(
                                  SurvivorItemsPage.routeName,
                                  arguments: routeArgs)),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: _minButtonHeight),
                          child: MaterialButton(
                              elevation: _defaultElevationValues,
                              color: heavyDark,
                              child: Text(
                                'Ver ítens',
                                style: _actionTextStyle,
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () => print('ver itens')),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: _minButtonHeight),
                          child: MaterialButton(
                              padding: EdgeInsets.all(10),
                              color: heavyDark,
                              elevation: _defaultElevationValues,
                              child: Text('Ver no mapa',
                                  style: _actionTextStyle,
                                  textAlign: TextAlign.center),
                              onPressed: () => print('vamos lá')),
                        ),
                      ),
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
