import 'package:coffee_crew/services/auth.dart';
import 'package:coffee_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // created an authService object to get instance of its working

  final AuthService _auth = AuthService();
  final _fromKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text("Sign In to Coffee"),
        backgroundColor: Colors.brown[400],
        elevation: 3.0,
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white70,
            ),
            onPressed: () {
              widget.toggleView();
            },
            icon: const Icon(Icons.person),
            label: const Text("Register"),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _fromKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
                validator: (val) => val!.isEmpty ? "Enter email" : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                validator: (val) =>
                val!.length < 6 ? 'Enter a password 6+ characters' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if(_fromKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);

                    if (result == null) {
                      setState(() {
                        loading =false;
                        error = "InCorrect credentials";
                      });
                    }
                  }

                  // print("📧 " + email);
                  // print("🔑 " + password);
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              )
            ],
          ),
        ),

        // SIGN-IN ANONYMOUSLY
        // child: ElevatedButton(
        //   child: Text("Sign in anonymously"),
        //   onPressed: () async {
        //
        //     dynamic result = await _auth.signInAnon();
        //
        //     if (result == null) {
        //       print("error 😭");
        //     } else {
        //       print("signed in 🥳");
        //       print(result.uid);
        //     }
        //   },
        // ),
      ),
    );
  }
}
