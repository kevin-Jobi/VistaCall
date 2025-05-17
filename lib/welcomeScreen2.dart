import 'package:flutter/material.dart';

class Welcomescreen2 extends StatefulWidget {
  const Welcomescreen2({super.key});

  @override
  State<Welcomescreen2> createState() => _Welcomescreen2State();
}

class _Welcomescreen2State extends State<Welcomescreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.asset('assets/images/ws2.png', width: 285, height: 280),
            const SizedBox(height: 1),
            const Text(
              'Expert Care, Anytime,\n Anywhere\n "Access a network of\n trusted doctors and\n health tools to manage\n your symptoms,\n medications, and\n  appointments, ready to\n support your wellness\n journey when you need\n it."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 21),
            TextButton(
              onPressed: () {},
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 5, 19, 140),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_forward),
        // shape: CircleBorder(),
      ),
    );
  }
}
