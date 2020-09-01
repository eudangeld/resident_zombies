import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../api/api.dart';
import '../locale/app_localizations.dart';

/// Localizations shortcut
AppLocalizations lz(BuildContext context) => AppLocalizations.of(context);

/// Api shortcut
Api api(BuildContext context) => Provider.of<Api>(context, listen: false);
