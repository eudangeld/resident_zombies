import 'package:flutter/material.dart';
import 'package:resident_zombies/util/helper.dart';

class LoginPage extends StatelessWidget {
  static String get routeName => '@routes/login_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lz(context).loginPageTitle),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              'Faça o seu login',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
