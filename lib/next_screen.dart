import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NextScreen extends StatelessWidget {
  final dynamic user;
  const NextScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SvgPicture.asset('assets/svg/login_background.svg'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 180),
                SvgPicture.asset('assets/svg/logo.svg'),
                const SizedBox(height: 120),
                Text('WELCOME, $user', style: const TextStyle(fontSize: 20, color: Colors.white),),
              ],
            ),
          )
        ],
      ),
    );
  }
}