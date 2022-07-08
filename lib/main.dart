import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'next_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(home: MyApp()));
}

final _auth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final myControllerPassword = TextEditingController();
  final myControllerUsername = TextEditingController();
  bool isEmpty = true;
  bool viewPassword = true;
  String passwordField = '';
  String emailField = '';
  bool showValidation = false;

  @override
  void initState() {
    super.initState();
    myControllerPassword.addListener(() {
      checkEmpty();
    });
    myControllerUsername.addListener(() {
      checkEmpty();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/svg/login_background.svg',
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 40.0),
                child: Column(
                  children: [
                    const SizedBox(height: 180),
                    SvgPicture.asset('assets/svg/logo.svg'),
                    const SizedBox(height: 120),
                    Form(
                      child: TextFormField(
                        controller: myControllerUsername,
                        onChanged: (value) {
                          emailField = value;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          labelStyle: TextStyle(
                              color: showValidation ? Colors.red : Colors.grey),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      child: TextFormField(
                        obscureText: viewPassword,
                        controller: myControllerPassword,
                        onChanged: (value) {
                          passwordField = value;
                        },
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          labelStyle: TextStyle(
                              color: showValidation ? Colors.red : Colors.grey),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: viewPassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                viewPassword = !viewPassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: (isEmpty
                            ? null
                            : () async {
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email: emailField,
                                      password: passwordField);
                                } catch (e) {
                                  return setState(() {
                                    showValidation = true;
                                  });
                                }

                                if (mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              NextScreen(user: emailField)));
                                }
                              }),
                        child: const Text('LOGIN'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkEmpty() {
    if (myControllerUsername.text.isNotEmpty &&
        myControllerPassword.text.isNotEmpty) {
      setState(() {
        isEmpty = false;
      });
    } else {
      setState(() {
        isEmpty = true;
      });
    }
  }
}
