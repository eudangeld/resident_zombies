import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resident_zombies/pages/register_page.dart';
import 'api/api.dart';
import 'locale/app_localizations.dart';
import 'model/routes.dart';
import 'pages/not_found.dart';

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

  @override
  void initState() {
    super.initState();
    _initialRoute = RegisterPage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        inProvider<Api>(_api),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            elevation: 0,
            color: Colors.white,
          ),
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
          const Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
        ],
      ),
    );
  }

  Route<dynamic> useGenerateRoute(RouteSettings settings) {
    if (appRoutes.containsKey(settings.name)) {
      final builder = appRoutes[settings.name];

      if (appRoutes.containsKey(settings.name)) {
        final builder = appRoutes[settings.name];

        return inPageRoute(builder(context),
            RouteSettings(name: settings.name, arguments: settings.arguments));
      }
    }
    return inPageRoute(NotFoundPage());
  }
}

Provider<T> inProvider<T>(T value) =>
    Provider<T>.value(value: value, updateShouldNotify: (_, __) => false);

MaterialPageRoute inPageRoute(Widget child, [RouteSettings settings]) =>
    MaterialPageRoute(builder: (context) => child, settings: settings);
