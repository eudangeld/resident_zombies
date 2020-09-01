import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get appName => 'The resident zombies';
  String get back => 'Voltar';
  String get notFound => 'Não encontrada';

  /// Loginpage texts
  /// Store here login page strings
  String get loginPageBodyTitle =>
      'Pelo visto você ainda não é um sobrevivente, faça seu cadastro e veja se realmente é um sobrevivente.';

  String get nameFormHint => 'Nome';
  String get ageFormHint => 'Idade';
  String get loginPageBarTitle => 'Seja bem vindo';
  String get register => 'Cadastrar';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['pt'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
