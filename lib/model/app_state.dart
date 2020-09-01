import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:rxdart/subjects.dart';

class AppState {
  final currentMapPosition = BehaviorSubject<LatLng>.seeded(LatLng(0, 0));
  final user = BehaviorSubject<User>.seeded(User());
}
