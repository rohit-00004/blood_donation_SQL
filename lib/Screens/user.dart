import 'package:blood_donation_sql/constants.dart';
import 'package:blood_donation_sql/db/database_helper.dart';
import 'package:blood_donation_sql/db/firebase_service.dart';
import 'package:blood_donation_sql/models/diseases_model.dart';
import 'package:blood_donation_sql/models/doctor_model.dart';
import 'package:blood_donation_sql/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatefulWidget {
   UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final dbhelper = DatabaseHelper.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? email = '';
  bool userPresent = false;
  String timeAlloted = "Not alloted";
  String bedAlloted = "Not alloted";
  String docAssigned = "Not assigned";

  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    // if(auth != null){
      if(user != null){
        email = user!.email;
        checkUserStatus(email);
      }
      timeAndDateUtility();
      // final User? user = auth.currentUser();
    // }
    super.initState();
  }

  Future checkUserStatus(String? email) async{
    bool res = await dbhelper.checkUserPresent(email);

    if(res){
      setState(() {
        userPresent = true;
      });
    }
  }

  Future timeAndDateUtility() async{
    if(user == null) return;

    String t = await dbhelper.getTime(user!.email!);
    String b = await dbhelper.getBednum(user!.email!);
    String d = await dbhelper.getDoctorForStudent(int.parse(b));
    // String d = await dbhelper.getDoctorForStudent(user!.email!);
    setState(() {
      timeAlloted = t;
      bedAlloted = b;
      docAssigned = d;
    },);
  }
  

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    
    return Scaffold(
        appBar: AppBar(
          title: 
          // userPresent == false ?
          const Text('Hello ', style: TextStyle(fontStyle: FontStyle.italic),), 
          // : Text("Hello ") ,
          backgroundColor: kRed,
        ),
        drawer: SafeArea(
          child: SizedBox(
            width: sz.width*.7,
            child: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const UserAccountsDrawerHeader(
                    accountName: 
                    // userPresent == false ? 
                        Text("User"), 
                    // : Text(user!.displayName!.toUpperCase()),
                    accountEmail: 
                    // userPresent == false ? 
                     Text("user-email"), 
                    // : Text(user!.email!),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text(
                        "R",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(
                      "Home",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/landing');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text(
                      "Profile",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.app_registration_rounded),
                    title: const Text(
                      "Enroll yourself",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/register').then((_) {
                        if(user != null){
                          email = user!.email;
                          checkUserStatus(email);
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_card),
                    title: const Text("Certificate",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Divider(height: 10, thickness: 2,),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Log out",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: () async {
                      // Navigator.pop(context);
                      Navigator.of(context).
                      pushNamedAndRemoveUntil('/landing', (route) => false);
                      await Services.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: 
         SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image(Image.asset('assets/images/donation.png')),
              Row(
                children: [
              SizedBox(
                width: sz.width,
                // decoration: BoxDecoration(border: Border.all(color: kRed)),
                child: Image.asset('assets/images/donation.png', height: 300,)),
        
                ],
              ),
        
              SizedBox(height: sz.height*.1,),

              userPresent == false ?
              userNotEnrolled(sz):
              Container(
                width: sz.width * .8,
                decoration: const BoxDecoration(
                        // backgroundBlendMode:
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.0)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(6, 1.0), //(x,y)
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children:  [
                    Row(
                      children: [
                        const Text(
                                  'Alloted time slot:',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                    Text(
                              timeAlloted,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                      ],
                    ),
                    SizedBox(height: sz.height * .01),
                    Row(
                      children: [
                        const Text(
                                  'Assigned doctor: ',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                    Text(
                              // dbhelper.getDoctorForStudent(bedno),
                              docAssigned,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                      ],
                    ),
                    SizedBox(height: sz.height * .01),
                    Row(
                      children: [
                        const Text(
                                  // dbhelper.getDoctorForStudent(bedno),
                                  'Bed number: ',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                    Text(
                              // dbhelper.getDoctorForStudent(bedno),
                              bedAlloted,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                      ],
                    ),
                  ]),
                ),
              ),
        
            //   ElevatedButton(onPressed: () async{
            //     Student s = Student(mis: 112003079, 
            //     haemoglobinCount: 100, 
            //     name: 'Rohit', gender: 'Male', 
            //     bloodGroup: 'O+', email: 'rohitmagar084@g.com', 
            //     certificateGiven: false, 
            //     donated: false, weight: 60);
        
            //     await dbhelper.createStudent(s);        
        
            //     print("inserted ${s.name}");
        
        
            //   }, 
            //   child: const Text('insert')),
            // ElevatedButton(onPressed: () async{
            //     int? cnt = await dbhelper.numberOfStudents();
        
            //     if(cnt == null){
            //       print("Null students");
            //     }
            //     else {
            //       print("$cnt students");
            //     }
            // }, 
            // child: const Text('Number of students')),
            // ElevatedButton(onPressed: () async{
            //   final allrows = await dbhelper.readallStudents();
        
            //   for(var v in allrows){
            //     print(v.toJson());
            //   }
            // }, 
            // child: const Text('query all students')),
        
            // ElevatedButton(onPressed: ()async{
            //   try{
            //   await dbhelper.deleteAllStudents();
            //   print("deleted studs");
            //   }
            //   catch(e){
            //     Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
            //   }
            // }, 
            // child: const Text('delete students data')),
            // ElevatedButton(onPressed: () async{
            // Diseases dis = Diseases(mis: 112003079, disease: 'No disease');
            // await dbhelper.createDisease(dis);
            //   // bool status = await dbhelper.checkDonatedStatus(112003079);
            //   print('disease created');
            // }, 
            // child: const Text('insert disease')),
            // ElevatedButton(onPressed: ()async{
            //    String name =  await dbhelper.getDoctorForStudent(8);

            //   print("doctor assigned = $name");
            // }, 
            // child: const Text('get doctor from bedno')),
            // ElevatedButton(onPressed: () async{
            //   try{
            //   await dbhelper.showTables();
            //   }
            //   catch(e){
            //     Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
            //   }
            // }, 
            // child: const Text('show tables'))
            ],
          ),
        ));
  }

  Column userNotEnrolled(Size sz) {
    return Column(
              children: [
                Container(
                  width: sz.width,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: kGreen),
                  // ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Not enrolled yet',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  width: sz.width,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: kBlack),
                  // ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Enroll to see details',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            );
  }
}
