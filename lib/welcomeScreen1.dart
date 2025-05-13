import 'package:flutter/material.dart';

class Welcomescreen1 extends StatefulWidget {
  const Welcomescreen1({super.key});

  @override
  State<Welcomescreen1> createState() => _Welcomescreen1State();
}

class _Welcomescreen1State extends State<Welcomescreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ws1.png',)
          ],
        ),
      ),
    );
  }
}