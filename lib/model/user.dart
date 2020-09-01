import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Gender { male, female, other }

class User {
  String name;
  int age;
  Gender gender;
  LatLng lastLocation;
}
