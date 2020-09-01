import 'package:flutter/material.dart';
import '../pages/all_players_page.dart';
import '../pages/main_game_page.dart';
import '../pages/register_page.dart';

// Keep here routes that users need to be logged to aceess
// This string are aceessed onApp ongenerateRoute method
List<String> get useLoggedRoutes => [];

/// leave All routes here
/// this obj are used on main class
Map<String, WidgetBuilder> get appRoutes => {
      RegisterPage.routeName: (_) => RegisterPage(),
      MaingamePage.routeName: (_) => MaingamePage(),
      AllPLayersPage.routeName: (_) => AllPLayersPage(),
    };
