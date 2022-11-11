import 'package:blood_donation_sql/Screens/admin.dart';
import 'package:blood_donation_sql/Screens/landing.dart';
import 'package:blood_donation_sql/Screens/loading.dart';
import 'package:blood_donation_sql/Screens/register.dart';
import 'package:blood_donation_sql/Screens/user.dart';
import 'package:blood_donation_sql/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'db/firebase_service.dart';

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
      debugShowCheckedModeBanner: false,
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
                Navigator.pushReplacementNamed(context, '/user');
              }),
            ],
          );
        },
        '/profile': (context) {
          return Services.checkSignedIn() == false ?
           const Center(
                  child: Text(
                    'No donations yet',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ):
           ProfileScreen(
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
        '/user' : (context) => UserPage(), 
        '/landing': (context) => const Landing(),
        '/admin':(context) => const AdminPage(),
        '/loading':(context) => const Loader(),
        
      },
    );
  }
}