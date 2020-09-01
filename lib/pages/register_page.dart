import 'package:flutter/material.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';

class RegisterPage extends StatelessWidget {
  static String get routeName => '@routes/register_page';

  final _loginFormKey = GlobalKey<FormState>();

  /// Return a simple form filed
  /// Refact: Move to build
  ///
  TextFormField _field(
          {TextEditingController controller,
          Function validator,
          String hint,
          TextInputType inputType}) =>
      TextFormField(
          keyboardType: inputType ?? TextInputType.text,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: hint.toUpperCase()),
          textAlign: TextAlign.start);

  /// Form action
  /// Called when register button is called
  submitFormAction() {
    if (_loginFormKey.currentState.validate()) {
      print('validou maninhop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheetButton(
          label: lz(context).register, onPressed: submitFormAction),
      appBar: AppBar(
        title: Text(lz(context).loginPageBarTitle),
      ),
      body: Form(
        key: _loginFormKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Text(lz(context).loginPageBodyTitle,
                  style: TextStyle(color: Colors.black)),
              _field(
                controller: TextEditingController(),
                validator: (String value) =>
                    value.isEmpty ? lz(context).nameFormError : null,
                hint: lz(context).appName,
              ),
              _field(
                inputType: TextInputType.number,
                controller: TextEditingController(),
                validator: (String value) =>
                    value.isEmpty ? lz(context).nameFormError : null,
                hint: lz(context).ageFormHint,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
