import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:resident_zombies/pages/profile_page.dart';
import 'package:resident_zombies/util/helper.dart';

import '../widgets/game_drawer.dart';
import '../widgets/loading_widget.dart';

class MainGamePage extends StatefulWidget {
  static String get routeName => '@routes/main_game_page';
  @override
  _MainGamePageState createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  GoogleMapController _controller;
  BitmapDescriptor _markerIcon;
  BitmapDescriptor _playerIcon;
  Set<Marker> _markers = Set<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _userMark() {
    if (_markerIcon == null) {
      BitmapDescriptor.fromAssetImage(
              createLocalImageConfiguration(context,
                  size: Size(MediaQuery.of(context).size.width * 01,
                      MediaQuery.of(context).size.width * 01)),
              'assets/player_map_icon.png')
          .then(_updateMarker);
    }
  }

  void _playerMark() {
    if (_playerIcon == null) {
      BitmapDescriptor.fromAssetImage(
              createLocalImageConfiguration(context,
                  size: Size(MediaQuery.of(context).size.width * 01,
                      MediaQuery.of(context).size.width * 01)),
              'assets/me_icon.png')
          .then(((value) => setState(() => _playerIcon = value)));
    }
  }

  void _updateMarker(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userMark();
    _playerMark();
    getPositionStream(
            desiredAccuracy: LocationAccuracy.best, distanceFilter: 100)
        .listen((Position position) {
      if (position != null) {
        final _stateUser = state(context).user.value;
        final _newLocation = LatLng(position.latitude, position.longitude);

        if (_markers != null) {
          Marker _userMarker = _markers?.firstWhere(
            (element) => element.markerId.value == _stateUser.name,
            orElse: () => Marker(markerId: MarkerId('notFound')),
          );
          _userMarker = Marker(
            icon: _playerIcon,
            infoWindow: InfoWindow(
              title: _stateUser.name,
              snippet: 'Ver perfil',
              onTap: () => Navigator.of(context).pushNamed(
                  PlayerProfilePage.routeName,
                  arguments: _stateUser.id),
            ),
            markerId: MarkerId(_stateUser.name),
          );

          if (_userMarker.markerId.value == _stateUser.name) {
            setState(() {
              _markers.add(_userMarker);
            });
          }
        }

        state(context).currentMapPosition.add(_newLocation);

        api(context)
            .updateSurvivor(
                state(context).user.value..lastLocation = _newLocation)
            .then((value) => updatePosition(_newLocation));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mundo - TRZ', style: TextStyle(color: Colors.white)),
        ),
        drawer: Drawer(child: GameDrawer()),
        body: FutureBuilder(
            future: api(context).getAll(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final _all = snapshot.data as List<dynamic>;
                _markers = Set<Marker>();
                _markers.addAll(_all.map(
                  (f) => Marker(
                      // onTap: () => print(strToCrdinates(f['lonlat'])),
                      icon: _markerIcon,
                      infoWindow: InfoWindow(
                        title: f['name'],
                        snippet: 'Ver perfil',
                        onTap: () => Navigator.of(context).pushNamed(
                            PlayerProfilePage.routeName,
                            arguments: getIdFromLocation(f['location'])),
                      ),
                      markerId: MarkerId(f['name']),
                      position: strToCrdinates(f['lonlat'])),
                ));

                return StreamBuilder<LatLng>(
                    stream: state(context).currentMapPosition,
                    builder:
                        (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
                      if (snapshot.hasData) {
                        updatePosition(snapshot.data);
                        return Stack(
                          children: [
                            GoogleMap(
                              myLocationButtonEnabled: true,
                              zoomControlsEnabled: true,
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                  target:
                                      state(context).user.value.lastLocation ??
                                          LatLng(snapshot.data.latitude,
                                              snapshot.data.longitude),
                                  zoom: 15.0),
                              onMapCreated: _onMapCreated,
                              markers: _markers,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    height: 205,
                                    child: AllPLayersMarker(
                                      players: _all,
                                    )),
                              ],
                            ),
                          ],
                        );
                      }
                      return Loading();
                    });
              }

              return Loading();
            }));
  }

  void updatePosition(LatLng newPosition) {
    if (_controller != null) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(tilt: 30.0, zoom: 15.0, target: newPosition)));
    }
  }
}

//// This class render all player on a pageview
///
///when user changed the page the current postion on map is updated
///
///
class AllPLayersMarker extends StatefulWidget {
  const AllPLayersMarker({Key key, this.players}) : super(key: key);

  @override
  _AllPLayersMarkerState createState() => _AllPLayersMarkerState();

  final List<dynamic> players;
}

class _AllPLayersMarkerState extends State<AllPLayersMarker> {
  final _controller = PageController(viewportFraction: 0.8);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.addListener(onScrollChange);
  }

  void onScrollChange() {
    final int _currentIndex = _controller.page.round().toInt();
    final _usr = User.fromJson(widget.players[_currentIndex]);
    state(context).currentMapPosition.add(_usr.lastLocation);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.players.length,
      controller: _controller,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    child: Image.asset(
                        getIdFromLocation(widget.players[index]['location']) ==
                                user(context).id
                            ? 'assets/male_player.png'
                            : 'assets/zombie_002.png'),
                    constraints: BoxConstraints(maxHeight: 120),
                  ),
                ),
                Expanded(child: Text(widget.players[index]['name'])),
              ],
            ),
          ),
          color: Colors.white,
        ),
      ),
    );
  }
}
