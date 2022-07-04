import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

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
              SvgPicture.asset('assets/svg/login_background.svg'),
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
                          decoration: const InputDecoration(
                            label: Text('Username'),
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
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
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            labelStyle: const TextStyle(color: Colors.grey),
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
                        onPressed: (isEmpty ? null : () {}),
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
