import 'package:blood_donation_sql/db/database_helper.dart';
import 'package:blood_donation_sql/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor admin'),),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton(onPressed: () async{
            final db1 = DatabaseHelper.instance.database;
      
            Doctor doc = Doctor(id:4, bedno: 1, age: 35, name: 'Manas');
            await dbhelper.create(doc);
            print("inserted");
            // DatabaseHelper.instance.create(doc);

          }, 
          child: const Text('insert in db')),

          ElevatedButton(onPressed: () async{
            print("printing all doctors");
            List<Doctor> allrows =  await dbhelper.readAllDoctors();
            
            allrows.forEach((element) {print(element);});
          }, 
          child: Text('query all')),

          ElevatedButton(onPressed: () async{
            int rows = await dbhelper.updatedoc(4, 'sanam');
          }, 
          child: Text('Update doctor name')),

          ElevatedButton(
            onPressed: (){
              // DatabaseHelper.instance.deleteDatabase('blooddonation.db');
              DatabaseHelper.instance.deletedoctors();
              print('deleted doctor');
            },
            child: const Text('delete all database')
          ),
          // FutureBuilder(
          //   future: dbhelper.readAllDoctors(),
          //   builder: (context, snapshot) {
          //     if(snapshot.hasData){
          //       return Text(snapshot.data.toString());
          //     }
          //     return const CircularProgressIndicator();
              
          //   },
          // )
        ]),
      ),

  
    );

  }
}
