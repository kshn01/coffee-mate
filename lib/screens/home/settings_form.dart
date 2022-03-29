import 'package:flutter/material.dart';


class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0','1','2','3','4'];

  String? _currentName;
  String? _currentSugars;
  String? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _formKey,
      child: Form(child:Column(
        children: [
          
        ],
      ) ),
    );
  }
}
