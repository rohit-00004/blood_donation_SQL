

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Services{
  final User? user = FirebaseAuth.instance.currentUser;

  static Future<void> signOut() async{
    try{
    await FirebaseAuth.instance.signOut();
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  static Future<bool> checkSignedIn() async{
    final User? user = FirebaseAuth.instance.currentUser;

    if(user == null) return false;
    return true;
  }
}