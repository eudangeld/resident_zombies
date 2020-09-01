import 'package:flutter/material.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/bottom_sheet_button.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';

class RegisterPage extends StatefulWidget {
  static String get routeName => '@routes/register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  bool _loading = false;

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
            labelText: hint.toUpperCase(),
            border: InputBorder.none,
          ),
          textAlign: TextAlign.start);

  /// Form action
  /// Called when register button is called
  submitFormAction(context) async {
    if (_loginFormKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      final _registerResult = await api(context).register(
        name: _nameController.text,
        age: int.tryParse(_ageController.text),
        gender: 'F',
        items: '',
      );
      if (_registerResult != null) {
        await Navigator.of(context)
            .pushReplacementNamed(MaingamePage.routeName);
      }
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BottomSheetButton(
          label: lz(context).register,
          onPressed: () => submitFormAction(context)),
      appBar: AppBar(title: Text(lz(context).registerPageBarTitle)),
      body: Form(
        key: _loginFormKey,
        child: _loading
            ? Loading()
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Image.asset('assets/zombie_002.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(lz(context).registerPageBodyTitle,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 22)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              _field(
                                controller: _nameController,
                                validator: (String value) => value.isEmpty
                                    ? lz(context).nameFormError
                                    : null,
                                hint: lz(context).nameFormHint,
                              ),
                              SizedBox(height: 30),
                              _field(
                                inputType: TextInputType.number,
                                controller: _ageController,
                                validator: (String value) => value.isEmpty
                                    ? lz(context).ageFormError
                                    : null,
                                hint: lz(context).ageFormHint,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
