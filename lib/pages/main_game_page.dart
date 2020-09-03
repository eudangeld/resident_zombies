import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  void _updateMarker(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userMark();
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
            icon: _markerIcon,
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
        appBar: AppBar(),
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
                        return GoogleMap(
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: state(context).user.value.lastLocation ??
                                  LatLng(snapshot.data.latitude,
                                      snapshot.data.longitude),
                              zoom: 15.0),
                          onMapCreated: _onMapCreated,
                          markers: _markers,
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
