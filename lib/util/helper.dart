import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../api/api.dart';
import '../locale/app_localizations.dart';

/// Localizations shortcut
AppLocalizations lz(BuildContext context) => AppLocalizations.of(context);

/// Api shortcut
Api api(BuildContext context) => Provider.of<Api>(context, listen: false);

/// Stores a [user] using shared preferences
///
///
Future<User> storeRegisteredUserOnDevice(User user) async {
  //TODO: ASSERT PROPS
  final prefs = await localStorage();
  await prefs.setString('id', user.id);
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
