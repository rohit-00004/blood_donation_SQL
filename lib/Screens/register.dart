import 'package:blood_donation_sql/constants.dart';
import 'package:blood_donation_sql/db/database_helper.dart';
import 'package:blood_donation_sql/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/diseases_model.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final donorname = TextEditingController();
  // final _bgcontroller = TextEditingController();

  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String selectedGroup = 'O+';
  // String name = '';

  List<bool> checks = [false, false, false, false, false];
  // String bloodgroup = "";
  List<String> diseases = [
    'Unexplained Weight Loss',
    'HIV',
    'Hepatitis B',
    'Hepatitis C',
    'Syphilis'
  ];

  Student user = Student(
    name: '', email: '', mis: 0, haemoglobinCount: 0, weight: 0, gender: '',
    certificateGiven: false, donated: false, bloodGroup: 'O+'
  );
  final dbhelper = DatabaseHelper.instance;

  // final _auth = FirebaseAuth.instance;
  // User? user;
  @override
  void initState() {
    // checkUserStatus(email);
    
    // TODO: implement initState
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  bool userPresent = false;

   Future checkUserStatus(String? email) async{
    bool res = await dbhelper.checkUserPresent(email);

    if(res){
      setState(() {
        userPresent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w900),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 178, 178),
      ),
      // backgroundColor: kbg1,
      backgroundColor: kbg2,
      // backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: 
        userPresent == true ?
        const Center(
              child: Text('You have already enrolled',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, 
              fontStyle: FontStyle.italic, color: Colors.grey ),),)
         : SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            
            child: Column(
              children: [
                SizedBox(height: sz.height * .01),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: buildTextform(sz, 'Donor\'s name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: buildTextform(sz, 'Email'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: numericInput('MIS', 'Your mis', true),
                    ),
                    SizedBox(
                      height: sz.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: sz.width * .8,
                        child: Row(
                          children: [
                            Flexible(
                              child: numericInput('Age', 'Age', false),
                            ),
                            SizedBox(
                              width: sz.width * .03,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: TextFormField(
                                    onSaved: (newValue) {
                                      setState(() {
                                        if(newValue != null){
                                          user.gender = newValue.toLowerCase();
                                        }
                                      });
                                    },
                                    validator: ((value) {
                                      if (value == null) {
                                        return 'Enter your gender';
                                      }

                                      value = value.toLowerCase();
                                      if (value == 'male' ||
                                          value == 'female' ||
                                          value == 'trans') {
                                        return null;
                                      } else {
                                        return 'Enter valid gender';
                                      }
                                    }),
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                                    decoration: const InputDecoration(
                                      
                                      suffixIcon: Icon(
                                        Icons.boy_sharp,
                                        size: 30,
                                      ),
                                      border: InputBorder.none,
                                      label:  Text('Gender'),
                                      hintText: 'Male',
                                     
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: sz.height * .02,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: sz.width * .8,
                        child:  Text(
                          'Blood Group',
                          style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 1.3),
                        ),
                      ),
                    ),

                    Container(
                      width: sz.width * .8,
                      decoration: BoxDecoration(
                          color: kWhite,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: DropdownButtonHideUnderline(
                          child: buildDropDown(),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: sz.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: sz.width * .8,
                        child: Row(
                          children: [
                            Flexible(
                                child: numericInput(
                                    'Haemoglobin count', 'in grams', false)),
                            SizedBox(
                              width: sz.width * .03,
                            ),
                            Flexible(
                              child: numericInput('Weight', 'in kg', false),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: sz.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: sz.width * .8,
                        child: Text(
                          'In the last 6 months, have you had history of any of the following:',
                          style: TextStyle(
                            color: kWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              letterSpacing: 1.3),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: diseases.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            title: Text(diseases[index], 
                            style: TextStyle(color: kWhite, 
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),),
                            trailing: Checkbox(
                              splashRadius: 30,
                              checkColor: Colors.black,
                              activeColor: kWhite,

                              onChanged: (value) {
                                setState(() {
                                  checks[index] = !checks[index];
                                });
                              },
                              value: checks[index],
                            ),
                          );
                        }),
                      ),
                    ),

                    SizedBox(
                      height: sz.height * .065,
                    ),

                    //ignore: sized_box_for_whitespace
                    Container(
                      height: sz.height * 0.055,
                      width: sz.width * .5,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            try{
                            _formKey.currentState!.save();

                          final res = await dbhelper.createStudent(user);

                          if(res == true){
                            await dbhelper.allotSlot(user.mis);
                          }
                          for(int i=0; i<5; i++){
                            if(checks[i] == true){
                              try{
                              Diseases dis = Diseases(mis: user.mis, disease: diseases[i]);
                              await dbhelper.createDisease(dis);
                              }
                              catch(e){
                                Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
                              }
                            }
                          }

                          if(res == true){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('User enrolled successfully!', 
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17 ),),
                              backgroundColor: kGreen,
                              duration: const Duration(seconds: 2),
                              // action: SnackBarAction(
                              //   // label: 'ACTION',
                              //   onPressed: () { },
                              // ),
                            ));
                          }
                          else{
                            Fluttertoast.showToast(msg: 'Could not insert student', gravity: ToastGravity.TOP);
                          }
                          
                            Navigator.pushNamed(context, '/user');
                          
                          }
                          catch(e){
                            Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
                          }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Proceed',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sz.height * .05,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Container numericInput(String label, String hint, bool mis) {
    var sz = MediaQuery.of(context).size;
    return Container(

      width: mis == true ? sz.width * 0.8 : sz.width,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: TextFormField(
          onSaved: (newValue){
            if(label == 'MIS'){
              if(newValue != null){
              setState(() => user.mis = int.parse(newValue),);
              }
            }
            else if(label == 'Haemoglobin count'){
              if(newValue != null){
              setState(() => user.haemoglobinCount = int.parse(newValue),);}
            }
            else if(label == 'Weight'){
              if(newValue != null){
              setState(() => user.weight = double.parse(newValue),);}
            }
          },
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return 'Enter valid $label';
            }

            if(mis == true && value.length != 9) return 'Enter valid MIS';

        
            if (isNumeric(value) == true && int.tryParse(value)! > 0) return null;
            
            return 'Enter valid $label';
          }),
          decoration: InputDecoration(
            border: InputBorder.none,
            label: Text(label),
            hintText: hint,
            hintStyle: TextStyle(color: kBlack),
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Container buildTextform(Size sz, String label) {
    return Container(
      width: sz.width * .8,

      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: TextFormField(
            onSaved: (newValue) {
              if(label == 'Email'){
                setState(() {
                  if(newValue != null){
                  user.email = newValue;}
                });
              }
              else{
                setState(() {
                  if(newValue != null){
                  user.name = newValue;}
                });
              }
            },
              validator: (value) {
             
                if (value == null || value.isEmpty) {
                  return 'This field can\'t be empty';
                }
                if(label == 'Email'){
                  final bool emailValid = 
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
                  if(emailValid == false){
                    return 'Invalid email';
                  }
                }
                return null;
              },
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  // : TextStyle(),
                  border: InputBorder.none,
                  labelText: label,
                  labelStyle: TextStyle(fontSize: 17, letterSpacing: 1.5)))),
      //  child: TextFormField(
      //   ),
    );
  }

  DropdownButton<String> buildDropDown() {
    return DropdownButton(
      value: selectedGroup,
      onChanged: (newValue) {
        setState(() {
          selectedGroup = newValue.toString();
          user.bloodGroup = selectedGroup;
        });
      },
      iconSize: 40,
      items: bloodGroups.map((bg) {
        return DropdownMenuItem(
          value: bg,
          child: Text(bg),
        );
      }).toList(),
    );
  }

  // Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);

}
