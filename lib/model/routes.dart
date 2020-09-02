import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/profile_page.dart';
import 'package:resident_zombies/pages/survivor_items_page.dart';
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
      MainGamePage.routeName: (_) => MainGamePage(),
      AllPLayersPage.routeName: (_) => AllPLayersPage(),
      PlayerProfilePage.routeName: (_) => PlayerProfilePage(),
      SurvivorItemsPage.routeName: (_) => SurvivorItemsPage(),
    };
