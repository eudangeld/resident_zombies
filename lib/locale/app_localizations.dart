import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

//// Store all strings of the game
///
/// i think the best way to keep this class usefull is grouping in blocks
/// by experience this class can be infected by disorder virus quickly.
/// Stay alert!
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get appName => 'The resident zombies';
  String get back => 'Voltar';
  String get notFound => 'Não encontrada';

  /// Register_page
  ///
  /// Keep here all string s related to the registerpage here
  String get registerPageBodyTitle =>
      'Pelo visto você ainda não é um sobrevivente, faça seu cadastro e veja se realmente se garante.';

  String get nameFormHint => 'Nome';
  String get nameFormError => 'Nome é obrigatório';

  String get ageFormHint => 'Idade';
  String get ageFormError => 'Idade obrigatória';

  String get registerPageBarTitle => 'Seja bem vindo';
  String get register => 'Cadastrar';

  ///
  ///

  ///Drawer menu
  ///
  ///
  String get drawerProfile => 'Perfil';
  String get drawereMap => 'Mapa';
  String get drawerItens => 'Meus itens';
  String get drawerFriends => 'Amigos';
  String get drawerAllPlayers => 'Todos os jogadores';
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
