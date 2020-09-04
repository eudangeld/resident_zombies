import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

final heavyDark = Color(0xff3a556a);

LinearGradient zombieGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: [0.1, 0.5, 0.9],
  colors: [Color(0xff3a556a), Color(0xcc3a556a), Color(0xff3a556a)],
);
