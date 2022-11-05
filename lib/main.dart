import 'package:blood_donation_sql/Screens/landing.dart';
import 'package:blood_donation_sql/Screens/register.dart';
import 'package:blood_donation_sql/Screens/user.dart';
import 'package:blood_donation_sql/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
 );

 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<AuthProvider<AuthListener, auth.AuthCredential>>?  providers = [EmailAuthProvider()];

    return MaterialApp(
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      initialRoute: '/landing',
      // initialRoute: auth.FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            providers: providers,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/home');
              }),
            ],
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            providers: providers,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/sign-in');
              }),
            ],
          );
        },
        '/home':(context) => const Home(),
        '/register':(context) => const Register(),
        '/user' : (context) => const UserPage(), 
        '/landing': (context) => const Landing(),
      },
    );
  }
}