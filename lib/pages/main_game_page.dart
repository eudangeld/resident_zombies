import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/util/helper.dart';
import '../widgets/game_drawer.dart';
import '../widgets/loading_widget.dart';
import '../model/user.dart';

class MaingamePage extends StatefulWidget {
  static String get routeName => '@routes/main_game_page';
  @override
  _MaingamePageState createState() => _MaingamePageState();
}

class _MaingamePageState extends State<MaingamePage> {
  GoogleMapController _controller;
  BitmapDescriptor _markerIcon;
  Set<Marker> _markers = Set<Marker>();

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  void _otherPlayoresMarkers(Iterable<User> users) {
    _markers = Set<Marker>();
    _markers.addAll(users.map(
      (f) => Marker(
        icon: _markerIcon,
        markerId: MarkerId(f.name),
        position: LatLng(f.lastLocation.latitude, f.lastLocation.longitude),
      ),
    ));
  }

  void _userMark() {
    if (_markerIcon == null) {
      BitmapDescriptor.fromAssetImage(
              createLocalImageConfiguration(context), 'assets/zombie_001.png')
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
    _userMark();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(child: GameDrawer()),
      body: StreamBuilder(
          stream: state(context).currentMapPosition,
          builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
            if (snapshot.hasData) {
              updatePosition();
              return GoogleMap(
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: state(context).user.value.lastLocation ??
                        LatLng(-23.5489, -46.6388),
                    zoom: 17.0),
                onMapCreated: _onMapCreated,
                markers: _markers,
              );
            }

            return Loading();
          }),
    );
  }

  void updatePosition() {
    if (_controller != null) {
      final _lat = state(context).currentMapPosition.value.latitude;
      final _lng = state(context).currentMapPosition.value.latitude;

      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(tilt: 30.0, zoom: 15.0, target: LatLng(_lat, _lng))));
    }
  }
}
