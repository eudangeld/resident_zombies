import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

//// Store all strings of the game
///
/// Avoid things like => common or global always prefer specificate page values
/// even the values became duplicated
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
      'Você não tem nenhum cadastro, para entrar você precisa se cadastrar.';

  String get nameFormHint => 'Nome';
  String get nameFormError => 'Nome é obrigatório';

  String get ageFormHint => 'Idade';
  String get ageFormError => 'Idade obrigatória';

  String get registerPageBarTitle => 'TRZ';
  String get register => 'Cadastrar';

  ///
  ///Player profile page
  ///
  ///
  String get profileUnknowValue => 'Não informado';
  String get profileSeeitens => 'Ver ítens';
  String get profileStatusYes => 'S';
  String get profileStatusNo => 'N';
  String get profileAge => 'idade';
  String get profileGender => 'sexo';
  String get profileStatusTitle => 'infectado';

  ///Drawer menu
  ///
  ///
  String get drawerProfile => 'Perfil';
  String get drawereMap => 'Ver mapa';
  String get drawerItens => 'Meus itens';
  String get drawerFriends => 'Amigos';
  String get drawerAllPlayers => 'Todos os jogadores';

  ///Survivor itens page
  ///
  ///
  String get itensTitle => 'Ítens disponíveis';
  String get intensSubtitle =>
      'Você pode trocar ítens com outros jogadores, coloque os ítens no carrinho, selecione os ítens que você vai usar na troca e seja feliz. \nPS: Não aceitamos trocas ou parcelamentos. ';
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
