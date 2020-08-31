import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Starting point
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
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            elevation: 0,
            color: Colors.white,
          ),
        ),
        title: 'Primeira Mesa',
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
}

Provider<T> inProvider<T>(T value) =>
    Provider<T>.value(value: value, updateShouldNotify: neverNotify);

MaterialPageRoute inPageRoute(Widget child, [RouteSettings settings]) =>
    MaterialPageRoute(builder: (context) => child, settings: settings);
