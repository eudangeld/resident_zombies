import 'package:flutter/widgets.dart';
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
  await prefs.setDouble('lat', user.lastLocation?.latitude ?? '');
  await prefs.setDouble('lng', user.lastLocation?.longitude ?? '');
  return User(
      id: user.id,
      name: user.name,
      age: user.age,
      gender: user.gender,
      lastLocation: user.lastLocation ?? '');
}

Future<SharedPreferences> localStorage() async {
  return await SharedPreferences.getInstance();
}
