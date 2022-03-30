import 'package:coffee_crew/models/my_user.dart';
import 'package:coffee_crew/services/databases.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return Container(
      child: StreamBuilder<MyUserData>(
          stream: DatabaseService(uid: user!.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MyUserData? myUserData = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Update ",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: myUserData!.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'please enter a name' : null,
                      onChanged: (val) => setState(() {
                        _currentName = val;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        value: (_currentSugars ?? myUserData.sugars),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'sugars',
                        ),
                        items: sugars.map((item) {
                          return DropdownMenuItem(
                              value: item, child: Text("$item sugars"));
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _currentSugars = val.toString();
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Slider(
                      activeColor: Colors.brown[
                          _currentStrength ?? (myUserData.strength ?? 0)],
                      // jugaad
                      inactiveColor: Colors.brown[100],
                      value: (_currentStrength ?? (myUserData.strength ?? 0))
                          .toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _currentStrength = val.round();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? myUserData.sugars,
                              _currentName ?? myUserData.name,
                              _currentStrength ?? myUserData.strength);

                          Navigator.pop(context);
                        }

                        // print(_currentName);
                        // print(_currentSugars);
                        // print(_currentStrength);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
