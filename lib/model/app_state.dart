import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:rxdart/subjects.dart';

class AppState {
  final currentMapPosition = BehaviorSubject<LatLng>.seeded(LatLng(0, 0));
  final user = BehaviorSubject<User>.seeded(User());

  /// Default app location
  ///
  /// [Codeminer42 SP location]
  /// Used when geolocator plugin throws an exception
  /// or u need some location and dant want to think wich location use
  final codeminerLocation = LatLng(-23.623660, -46.695790);
}
