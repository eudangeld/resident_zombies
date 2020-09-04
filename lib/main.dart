import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:resident_zombies/model/app_state.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/pages/register_page.dart';
import 'package:resident_zombies/theme/global_theme.dart';

import 'api/api.dart';
import 'locale/app_localizations.dart';
import 'model/routes.dart';
import 'model/user.dart';
import 'pages/not_found.dart';
import 'util/helper.dart';
import 'widgets/loading_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// Initial route name
  /// All Classes on pages folder want to be an string routeName
  /// If u need a logic to define a start route
  /// Ex: If user is previusly loggd show pageA else render PageB
  /// Use inistate to define a start loginc page
  String _initialRoute;

  /// used on provider
  /// and passed above the tree
  Api _api;

  /// Stores stream and data for app
  AppState _state;

  @override
  void initState() {
    super.initState();
    _api = Api();
    _state = AppState();
  }

  /// Used to define initial route
  ///
  /// check for data on device
  /// define initial route
  /// and set an initial user on state
  /// in order to verify if server was reseted or user stored on device really exist on server
  /// before sending to a main game route
  /// i call the [getUser] and check response code
  ///
  Future<bool> _defineInitialRoute() async {
    final _result = await checkStoredDataOnDevice();

    _result
        ? _initialRoute = MainGamePage.routeName
        : _initialRoute = RegisterPage.routeName;

    _state.user.add(await userFromStorage());
    _state.currentMapPosition.add(_state.user.value.lastLocation);
    if (_initialRoute == MainGamePage.routeName) {
      print('check and referesh user');
      final _userResetedorDeleted =
          await _api.getSurvivor(_state.user.value.id);
      if (_userResetedorDeleted.statusCode > 200) {
        print('this user has been deleted or server was reseted.');
        _initialRoute = RegisterPage.routeName;
      } else {
        final _startUser = User.fromJson(_userResetedorDeleted.data);
        _state.user.add(_startUser);
        await registerUserOnDevice(_startUser);
      }
    }

    return _result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _defineInitialRoute(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                inProvider<Api>(_api),
                inProvider<AppState>(_state),
              ],
              child: MaterialApp(
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    appBarTheme: AppBarTheme(
                        brightness: Brightness.light,
                        elevation: 0,
                        color: heavyDark),
                  ),
                  title: 'The resident zombies',
                  initialRoute: _initialRoute,
                  onGenerateRoute: useGenerateRoute,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    AppLocalizationsDelegate(),
                  ],
                  supportedLocales: [
                    const Locale.fromSubtags(
                        languageCode: 'pt', countryCode: 'BR')
                  ]),
            );
          }
          return Container(
            child: Loading(),
            color: Colors.white,
          );
        });
  }

  Route<dynamic> useGenerateRoute(RouteSettings settings) {
    if (appRoutes.containsKey(settings.name)) {
      final builder = appRoutes[settings.name];

      return inPageRoute(builder(context),
          RouteSettings(name: settings.name, arguments: settings.arguments));
    }

    /// Just to test initial route failures or route fails
    ///
    ///
    return inPageRoute(NotFoundPage());
  }
}

Provider<T> inProvider<T>(T value) =>
    Provider<T>.value(value: value, updateShouldNotify: (_, __) => false);

MaterialPageRoute inPageRoute(Widget child, [RouteSettings settings]) =>
    MaterialPageRoute(builder: (context) => child, settings: settings);
