import 'package:blood_donation_sql/constants.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key, 
  required this.name,
  required this.gender, required this.weight, 
  required this.hCnt,
  required this.mis,
  required this.bgrp

  });

  String name;
  String gender, bgrp;
  int hCnt, mis;
  double weight;
  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('User info'),
      backgroundColor: kRed,),
      body: SafeArea(
          child: Center(
            child: Container(
        height: 300,
        decoration: BoxDecoration(
          // border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Card(
          color: Color.fromARGB(255, 252, 230, 162),
          // shadowColor: kBlack,
           shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                          // Icon(Icons.person, size: 24, color: Colors.blueAccent),
                      decoration: const BoxDecoration(
                          color:  Color.fromARGB(255, 246, 181, 83),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),)),
                      padding: const EdgeInsets.all(10),
                      child:
                          Text(mis.toString(), 
                          style: const TextStyle(fontWeight: FontWeight.bold),),                        
                    ),
                    SizedBox(height: sz.height * .01,),
                    Container(
                      // decoration: const BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.only(
                      //         bottomRight: Radius.circular(12),
                      //         bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(12),
                      child: Text(" Name : $name", 
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      // decoration: const BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.only(
                      //         bottomRight: Radius.circular(12),
                      //         bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(12),
                      child: Text("Haemoglobin: $hCnt",
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      // decoration: const BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.only(
                      //         bottomRight: Radius.circular(12),
                      //         bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(12),
                      child: Text("Blood group: $bgrp",
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    
                    Container(
                      // decoration: const BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.only(
                      //         bottomRight: Radius.circular(12),
                      //         bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(12),
                      child: Text("Weight: $weight",
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      // decoration: const BoxDecoration(
                      //     color: Colors.blueAccent,
                      //     borderRadius: BorderRadius.only(
                      //         bottomRight: Radius.circular(12),
                      //         bottomLeft: Radius.circular(12))),
                      padding: const EdgeInsets.all(12),
                      child: Text("Gender: $gender",
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    
                  ],
                ),
              )
              //   ListTile(
              //   leading: Icon(Icons.album, size: 70),
              //   title: Text('Heart Shaker', style: TextStyle(color: Colors.black)),
              //   subtitle: Text('TWICE', style: TextStyle(color: Colors.black)),
              // )
            ]),
        ),
      ),
          )),
    );
  }
}
