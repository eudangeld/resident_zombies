import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:resident_zombies/model/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../api/api.dart';
import '../locale/app_localizations.dart';

/// Localizations shortcut
AppLocalizations lz(BuildContext context) => AppLocalizations.of(context);

/// Api shortcut
Api api(BuildContext context) => Provider.of<Api>(context, listen: false);

String getIdFromLocation(String location) =>
    location.substring(location.lastIndexOf('/') + 1);

/// State shortcut
AppState state(BuildContext context) =>
    Provider.of<AppState>(context, listen: false);

/// Stores a [user] using shared preferences
///
/// always replace last [User id] (Just one player yet)
Future<User> registeruserOnDevice(User user) async {
  //TODO: ASSERT PROPS
  final prefs = await localStorage();
  await prefs.setString('id', user.id);
  await prefs.setString('name', user.name);
  await prefs.setString('gender', user.gender.toString());
  await prefs.setInt('age', user.age);
  await prefs.setDouble('lat', user.lastLocation?.latitude ?? 0.0);
  await prefs.setDouble('lng', user.lastLocation?.longitude ?? 0.0);
  print('Saving user on device');
  user.toString();
  return user;
}

/// Convert userData POINT STR to LatLng
///
///TODO: FIND a better strategy to do that
LatLng strToCrdinates(String point) {
  if (point == null) {
    return LatLng(0.0, 0.0);
  }
  final _raw = point.replaceAll('POINT (', '').replaceAll(')', '');
  final _lat = _raw.split(' ')[0];
  final _lng = _raw.split(' ')[1];

  return LatLng(double.tryParse(_lat), double.tryParse(_lng));
}

/// Check for stored [id] on device
///
/// if [true] means that user was connect before
/// used to define the [initialRoute] on main
Future<bool> checkStoredDataOnDevice() async {
  final prefs = await localStorage();
  return prefs.containsKey('id');
}

Future<SharedPreferences> localStorage() async {
  return await SharedPreferences.getInstance();
}
