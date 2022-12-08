import 'package:blood_donation_sql/Screens/donated_list.dart';
import 'package:blood_donation_sql/Screens/loading.dart';
import 'package:blood_donation_sql/Screens/user_card.dart';
import 'package:blood_donation_sql/constants.dart';
import 'package:blood_donation_sql/db/database_helper.dart';
import 'package:blood_donation_sql/models/doctor_model.dart';
import 'package:blood_donation_sql/models/user_model.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // late Future<Database> db;
  DatabaseHelper dbhelper = DatabaseHelper.instance;
  // DatabaseHelper dbh = DatabaseHelper.instance;
  // dbh.da tabase = db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // DatabaseHelper.instance.initDB("blood_donation.db");
    // db = dbhelper.database;
  }

  bool val = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Doctor admin',
            ),
            backgroundColor: kRed,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Blood not donated',
                ),
                Tab(
                  text: 'Blood donated students',
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            ListOfNotDonatedStudents(dbhelper: dbhelper),
            const ListOfDonatedStudents(),
            // doctorDebug(dbhelper: dbhelper),
          ]),
          // const ListOfDonatedStudents(),
          // ListOfNotDonatedStudents(dbhelper: dbhelper)
          //  doctorDebug(dbhelper: dbhelper),
        ),
      ),
    );
  }
}

class doctorDebug extends StatelessWidget {
  const doctorDebug({
    Key? key,
    required this.dbhelper,
  }) : super(key: key);

  final DatabaseHelper dbhelper;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     physics: ScrollPhysics(),
     child:  Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           ElevatedButton(
               onPressed: () async {
                 Doctorinfo doc =
                     Doctorinfo(id: 10, name: 'Shailesh', age: 45);
                 await dbhelper.create(doc);
                 print("inserted");
                 // DatabaseHelper.instance.create(doc);
               },
               child: const Text('insert in doctable2 i.e docinfo')),
           ElevatedButton(
               onPressed: () async {
                 print("printing all doctors");
                 List<Doctorinfo> allrows = await dbhelper.readAllDoctors();

                 for (var element in allrows) {
                   print(element.toJson());
                 }
               },
               child: const Text('query all doc_info')),
           ElevatedButton(
               onPressed: () async {
                int bed = 3;
                // for(int i=2; i<=10; i++){
                 DoctorAndBed doc = DoctorAndBed(id: 10, bedno: 20);
                 await dbhelper.createDocBed(doc);

                 
                //  doc = DoctorAndBed(id: i, bedno: bed+1);
                //  await dbhelper.createDocBed(doc);
                //   bed++;
                // }

                 print("inserted");
                 // DatabaseHelper.instance.create(doc);
               },
               child: const Text('insert in doctable1 i.e doc_bed')),
           ElevatedButton(
               onPressed: () async {
                 print("printing all doc_bed");
                 List<DoctorAndBed> allrows =
                     await dbhelper.readAllDoctorAndBed();

                 allrows.forEach((element) {
                   print(element.toJson());
                 });
               },
               child: const Text('query all doc_bed')),
           ElevatedButton(
               onPressed: () async {
                 int rows = await dbhelper.updatedoc(4, 'Manas');
               },
               child: const Text('Update doctor name')),
           ElevatedButton(
               onPressed: () {
                 // DatabaseHelper.instance.deleteDatabase('blooddonation.db');
                 DatabaseHelper.instance.deletedoctors();
                 print('deleted doctor');
               },
               child: const Text('delete all database')),
           ElevatedButton(
               onPressed: () async {
                 // DatabaseHelper.instance.deleteDatabase('blooddonation.db');
                 print('Tables list');
                 await DatabaseHelper.instance.showTables();
               },
               child: const Text('show tables')),
           // listOfStudents(),
         ]),
          );
  }
}

class ListOfNotDonatedStudents extends StatefulWidget {
  const ListOfNotDonatedStudents({
    Key? key,
    required this.dbhelper,
  }) : super(key: key);

  final DatabaseHelper dbhelper;

  @override
  State<ListOfNotDonatedStudents> createState() => _ListOfNotDonatedStudentsState();
}

class _ListOfNotDonatedStudentsState extends State<ListOfNotDonatedStudents> {

  bool isLoading = true;
  late List<Student> notDonatedList;

  @override
  void initState() {
    refreshList();
    // TODO: implement initState
    super.initState();
  }

  Future refreshList() async {
  setState(() => isLoading = true);

  notDonatedList = await DatabaseHelper.instance.readallNotDonatedStudents();

  setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false ?
     notDonatedList.isEmpty == true ? 
     const Center(
              child: Text('No enrollments yet',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, 
              fontStyle: FontStyle.italic, color: Colors.grey ),),)
    :             
     ListView.builder(
              // shrinkWrap: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notDonatedList.length,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 80,
                  decoration: BoxDecoration(
                    // border: Border.all(color: kbg2, width: 3),
                    color: const Color.fromARGB(255, 183, 218, 247),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 10), // changes position of shadow
                      ),
                    ],
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    // borderRadius: BorderRadius.circular(50)
                  ),
                  child: ListTile(
                    onTap: (() {

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => UserCard(name: notDonatedList[index].name, gender: notDonatedList[index].gender, 
                        weight: notDonatedList[index].weight, hCnt: notDonatedList[index].haemoglobinCount, mis: notDonatedList[index].mis,
                        bgrp: notDonatedList[index].bloodGroup,)));
                    }),
                    leading: Container(
                      // radius: ,
                      decoration: BoxDecoration(
                          // border: Border.all(width: 2),
                          color: const Color.fromARGB(255, 246, 181, 83),
                          borderRadius: BorderRadius.circular(10)
                          // shape: BoxShape.

                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          notDonatedList[index].mis.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    title: Text(
                      notDonatedList[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          overflow: TextOverflow.visible),
                    ),
                    subtitle: Text(
                      notDonatedList[index].email,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                    trailing: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () async{
                                // change donated = 1
                                await widget.dbhelper.updateDonatedStatus(notDonatedList[index].mis);
                                setState(() {
                                  refreshList();
                                });
                              },
                              icon: Icon(
                                Icons.check,
                                size: 25,
                                color: kGreen,
                              ),
                            ),
                            // SizedBox(height: 5,),
                            IconButton(
                              onPressed: () async{
                                await widget.dbhelper.deleteStudent(notDonatedList[index].mis);
                                setState(() {
                                  refreshList();
                                },);
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 25,
                                color: kRed,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );

                // Text(notDonatedList[index].name);
              })
        : 
        const Loader();

     
  }
}
