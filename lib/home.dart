import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood donation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (() {
                Navigator.pushNamed(context, '/profile');
              }), 
            child: const Text('profile')),
            ElevatedButton(
              onPressed: (() {
                Navigator.pushNamed(context, '/register');
              }), 
            child: const Text('register')),
          ],
        ),
      ),
    );
  }
}