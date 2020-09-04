import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// Pop an Alert box to users
///
/// Used after an api call that needs an feedback to user
/// Receives  [http StatusCode] and  [BuildContext context] to define and show the messages
///
reportInfeteddAlertSuccess(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.success,
    title: 'Report recebido',
    desc:
        'Em breve uma equipe do grupo S.T.A.R.S será enviada ao local, para tentar te resgatar, fique atento!',
    buttons: [
      DialogButton(
        child: Text("Beleza!",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

reportInfeteddAlertSpam(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: 'De novo isso!',
    desc:
        'Procure não forçar a barra com informações redundantes. Você pode acabar se infectando assim.',
    buttons: [
      DialogButton(
        child: Text("Entendi",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
      DialogButton(
        child: Text("Dane-se!",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

reportInfeteddAlerError(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: 'Houve um problema dwessa vez!',
    desc:
        'Pro algum motivo nossas equipes não entenderam seu pedido ou você está fora da área de cobertura da S.T.A.R.S, envia um email para eudangeld@gmail.com se achar melhor.',
    buttons: [
      DialogButton(
        child: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

reportOurselfAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: 'Se tá maluko?',
    desc: 'Ninguém sai por aí gritando que está infectado.',
    buttons: [
      DialogButton(
        child: Text("ENTENDI",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

/// Show alert before call trade option
/// offer to user the option to cancel transaction
///
confirmTradeAlert(BuildContext context, Function confirmAction) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: 'Tem certeza ?',
    desc:
        'Pensa bem aí, essa é uma operação que não pode ser desfeita. Um erro aqui pode sgnificar ser infectado mais tarde.',
    buttons: [
      DialogButton(
        child: Text("CONFRIMAR",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () {
          Navigator.pop(context);
          confirmAction();
        },
        width: 120,
      ),
      DialogButton(
        child:
            Text("VOLTAR", style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () async {
          Navigator.pop(context);
        },
        width: 120,
      ),
    ],
  ).show();
}

/// Showed when register failed with nams has been taken
///
///
registerAlertNameHasBeenTakenFail(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: 'Hora de ser criativo',
    desc:
        'É, já existe algum sobrevivente com esse nome aí. Vai tentando, jaja você vai conseguir. Você pode tentar usar algum nome Finlandês por exemplo',
    buttons: [
      DialogButton(
        child:
            Text("Beleza", style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

/// Showed when register fail with an unknow error
///
///
registerUnknowError(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.error,
    title: 'Xi,temos um problema.',
    desc:
        'Houve um problema desconhecido pra se cadastrar você pode tentar novamente mais tarde.',
    buttons: [
      DialogButton(
        child: Text("Que saco!",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}

/// Showed an infected user try do something
///
///
infectedAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: 'Infectado!',
    desc:
        'Você ta infectado e não pode entrar aqui. Grita por socorro, vai qua alguém ouve você.',
    buttons: [
      DialogButton(
        child: Text("BUUUUUU!",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
  ).show();
}
