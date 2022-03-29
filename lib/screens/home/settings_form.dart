import 'package:flutter/material.dart';

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
    return Container(
      child: Form(
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                validator: (val) => val!.isEmpty ? 'please enter a name' : null,
                onChanged: (val) => setState(() {
                  _currentName = val;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                  value: (_currentSugars ?? '0'),
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
                activeColor: Colors.brown[_currentStrength ?? 100],
                inactiveColor:  Colors.brown[100],

                value: (_currentStrength ?? 100).toDouble(),
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
                  print(_currentName);
                  print(_currentSugars);
                  print(_currentStrength);
                },
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          )),
    );
  }
}
