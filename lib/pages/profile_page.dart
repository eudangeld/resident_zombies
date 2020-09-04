import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
import 'package:resident_zombies/theme/global_theme.dart';
import 'package:resident_zombies/util/alerts.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';
import 'package:resident_zombies/widgets/trade_itens_quantity.dart';

import '../util/helper.dart';

class PlayerProfilePage extends StatefulWidget {
  static String get routeName => '@routes/profile_page';
  @override
  _PlayerProfilePageState createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  /// Received from [navigator.argments]
  /// used to get from server
  /// if is null use state user
  dynamic routeArgs;

  //TODO: move styles to theme and rename it
  final _labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final _valueStyle = TextStyle(fontSize: 15);
  final _nameStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  final _actionTextStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  final _defaultItensGap = 15.0;

  ///Store retrivied user data from server
  ///use [User.fromJson] factory to populate data
  User _currentUser;

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

  ///See on map button Action
  ///
  ///add currentLatlng on state [currentMapPosition]
  ///and push route
  _seeOnMapAction() {
    state(context).currentMapPosition.add(_currentUser.lastLocation);
    Navigator.of(context).pushReplacementNamed(MainGamePage.routeName);
  }

  /// Report infection
  ///
  /// Note: no one runs away screaming I'm infected
  /// DevNotes: i assume wich 202 or 200 response is an ok
  /// Devnotes: i assume wich 422 error is a problema trying to report more than 2 same id
  /// Devnotes: i really dont like to use switch but i think this is better now
  /// Devnotes: call [api(context).strafeSomeone] if u want to infect someone

  _reportInfection() async {
    if (state(context).user.value.id == _currentUser.id) {
      reportOurselfAlert(context);
    } else {
      final Response<dynamic> _response = await api(context)
          .reportInfection(state(context).user.value.id, _currentUser.id);

      switch (_response.statusCode) {
        case 200:
          reportInfeteddAlertSuccess(context);
          break;
        case 202:
          reportInfeteddAlertSuccess(context);
          break;
        case 204:
          reportInfeteddAlertSuccess(context);
          break;
        case 422:
          reportInfeteddAlertSpam(context);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheetButton(
          label: 'Reportar infectado', onPressed: _reportInfection),
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: FutureBuilder(
          future: api(context).getSurvivor(routeArgs),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              _currentUser = User.fromJson(snapshot.data);

              /// Determine currentPlayer profile or not
              _playerProfile = _currentUser.id == state(context).user.value.id;

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
                  Text(_currentUser.name, style: _nameStyle),

                  /// you know when u are seeing your profile
                  /// add an (you) above name
                  ///TODO:MOVE YOU TO LOCALIZATIONS
                  _playerProfile
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
                              Text(_currentUser.gender, style: _valueStyle),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(lz(context).profileAge, style: _labelStyle),
                              Text(_currentUser.age.toString(),
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
                                  _currentUser.infected
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
                      !_playerProfile
                          ? Expanded(
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints(minHeight: _minButtonHeight),
                                child: MaterialButton(
                                    elevation: _defaultElevationValues,
                                    color: heavyDark,
                                    child: Text(
                                      'Trocar ítens',
                                      style: _actionTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      state(context).traderId = _currentUser.id;
                                      Navigator.of(context).pushNamed(
                                          TradeDetailsPage.routeName);
                                    }),
                              ),
                            )
                          : Container(),
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
                                onPressed: _seeOnMapAction)),
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
