import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

import '../util/helper.dart';

class PlayerProfilePage extends StatefulWidget {
  static String get routeName => '@routes/profile_page';
  @override
  _PlayerProfilePageState createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  dynamic routeArgs;
  final _labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  final _valueStyle = TextStyle(fontSize: 15);
  final _nameStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  final _defaultItensGap = 15.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeArgs = ModalRoute.of(context).settings.arguments;
    print(routeArgs);
  }

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
                      width: MediaQuery.of(context).size.width * .40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(color: Colors.white, width: 10.0)),
                      child: Image.asset('assets/zombie_002.png',
                          fit: BoxFit.fill)),
                  SizedBox(height: _defaultItensGap),
                  Text(_profileData['name'] ?? lz(context).profileUnknowValue,
                      style: _nameStyle),
                  Row(children: <Widget>[
                    InkWell(
                      child: Text(lz(context).profileSeeitens),
                      onTap: () => Navigator.of(context).popAndPushNamed(
                          SurvivorItemsPage.routeName,
                          arguments: routeArgs),
                    )
                  ]),
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
                ],
              );
            }
            return Loading();
          }),
    );
  }
}
