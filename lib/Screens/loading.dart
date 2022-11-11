import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 200, 200),
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.red,
            strokeWidth: 6,
          ),
        ),
      ),
    );
  }
}