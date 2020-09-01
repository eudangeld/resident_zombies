import 'package:flutter/material.dart';
import '../locale/app_localizations.dart';

/// This is just a class to use
/// on development
/// I know 404 dosn't exists on mobile development

class NotFoundPage extends StatelessWidget {
  static String get routeName => '@routes/not_found';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context).notFound),
          Center(
            child: FlatButton(
              child: Text(AppLocalizations.of(context).back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
    );
  }
}
