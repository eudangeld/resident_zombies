import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/login_page.dart';

// Keep here routes that users need to be logged to aceess
// This string are aceessed onApp ongenerateRoute method
List<String> get useLoggedRoutes => [];

/// leave All routes here
/// this onj are used on main class
Map<String, WidgetBuilder> get appRoutes => {
      LoginPage.routeName: (_) => LoginPage(),
    };
