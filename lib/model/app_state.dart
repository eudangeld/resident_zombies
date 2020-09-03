import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:rxdart/subjects.dart';

class AppState {
  /// Default app location
  ///
  /// [Codeminer42 SP location]
  /// Used when geolocator plugin throws an exception
  /// or u need some location and dant want to think wich location use
  final codeminerLocation = LatLng(-23.623660, -46.695790);

  /// Use that value to show position on maps
  /// Deafults to [Codeminer42 SP location]
  // ignore: close_sinks
  final currentMapPosition =
      BehaviorSubject<LatLng>.seeded(LatLng(-23.623660, -46.695790));

  ///current [User] on state
  ///last registered
  // ignore: close_sinks
  final user = BehaviorSubject<User>.seeded(User());
}
