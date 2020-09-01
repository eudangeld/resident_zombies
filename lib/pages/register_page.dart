import 'package:flutter/material.dart';
import 'package:resident_zombies/api/api.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';

class RegisterPage extends StatelessWidget {
  static String get routeName => '@routes/register_page';

  ///
  final _loginFormKey = GlobalKey<FormState>();

  TextFormField _field(
      {TextEditingController controller,
      Function validator,
      String hint,
      TextInputType inputType}) {
    return TextFormField(
        keyboardType: inputType ?? TextInputType.text,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: hint.toUpperCase()),
        textAlign: TextAlign.start);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheetButton(
        label: lz(context).register,
        onPressed: () => api(context).register(
          name: 'null',
          age: 10,
          gender: 'null',
          items: 'null',
        ),
      ),
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
                validator: (value) => 'OK',
                hint: lz(context).appName,
              ),
              _field(
                inputType: TextInputType.number,
                controller: TextEditingController(),
                validator: (value) => 'OK',
                hint: lz(context).ageFormHint,
              ),
              _field(
                  controller: TextEditingController(),
                  validator: (value) => 'OK',
                  hint: 'Sexo'),
            ],
          ),
        ),
      ),
    );
  }
}
