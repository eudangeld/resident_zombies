import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resident_zombies/model/user.dart';
import 'package:resident_zombies/pages/main_game_page.dart';
import 'package:resident_zombies/util/alerts.dart';
import 'package:resident_zombies/util/helper.dart';
import 'package:resident_zombies/widgets/button.dart';
import 'package:resident_zombies/widgets/loading_widget.dart';
import 'package:resident_zombies/widgets/social_login_buttons.dart';

class RegisterPage extends StatefulWidget {
  static String get routeName => '@routes/register_page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _loginFormKey = GlobalKey<FormState>();

  /// Controllers for input texts
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  /// [location] detected by sendor
  /// Defaults to [codeminerLocation] on state
  LatLng _registerLocation;

  ///when [true] hide current content and shows a circular prog indicator
  /// normally used to process async loginc with server
  /// but is possible use then to hjus tshow some feedback to users
  ///
  bool _loading = false;

  String _currentRadioValue = "M";

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

  /// Geolocator plugin call
  /// define wich currentUser[location]
  /// Recovery from exceptions using [deafultLocation] locate on appstate
  ///
  /// Knowing throws on [getCurrentPosition]
  /// Throws a [TimeoutException] when no location is received within the
  /// supplied [timeLimit] duration.
  /// Throws a [PermissionDeniedException] when trying to request the device's
  Future<LatLng> askForLocation() async {
    _registerLocation = state(context).codeminerLocation;
    try {
      final position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _registerLocation = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('error getting location using codeminer42 SP location');
    }
    return _registerLocation;
  }

  /// Form action
  /// Called when register button is called
  ///
  /// If server return ok the object is used
  /// to store a new User on device and state => user
  submitFormAction(context) async {
    if (_loginFormKey.currentState.validate()) {
      setState(() => _loading = true);

      // Call location plugin
      // Stores result on [_registerLocation]
      await askForLocation();

      //update state map location to show last location user
      //in that case register location
      state(context).currentMapPosition.add(_registerLocation);

      /// TODO : implement toJosn on user class too
      final _registerResult = await api(context).register(
          name: _nameController.text,
          age: int.tryParse(_ageController.text),
          gender: _currentRadioValue,
          items: '',
          location: _registerLocation);

      setState(() => _loading = false);

      if (_registerResult.statusCode > 204) {
        print(_registerResult.statusMessage);
        _registerResult.data['name'] == null
            ? registerUnknowError(context)
            : registerAlertNameHasBeenTakenFail(context);
      } else {
        state(context).user.add(
            await registerUserOnDevice(User.fromJson(_registerResult.data)));
        await Navigator.of(context)
            .pushReplacementNamed(MainGamePage.routeName);
      }
    }
  }

  ///Used to update [gender] value on screen
  ///defaults to [M]
  onRadioValueChange(value) => setState(() => _currentRadioValue = value);

  //TODO : move to body on scaffold
  Row _genderSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('MENINO', style: TextStyle(fontSize: 16.0)),
            Radio(
                value: 'M',
                onChanged: onRadioValueChange,
                groupValue: _currentRadioValue),
          ],
        ),
        Column(
          children: <Widget>[
            Text('MENINA', style: TextStyle(fontSize: 16.0)),
            Radio(
                value: 'F',
                groupValue: _currentRadioValue,
                onChanged: onRadioValueChange),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lz(context).registerPageBarTitle)),
      body: Form(
        key: _loginFormKey,
        child: _loading
            ? Loading()
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: 70, left: 20, right: 20),
                          child: Container(
                              child: Text('The Resident Zombie',
                                  key: Key('title-page-key'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 22))),
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
                                _genderSelect(),
                              ],
                            ),
                          ),
                        ),
                        SocialLoginButtons(),
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Button(
                              padding: EdgeInsets.all(20),
                              onPressed: () => submitFormAction(context),
                              label: lz(context).register),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
