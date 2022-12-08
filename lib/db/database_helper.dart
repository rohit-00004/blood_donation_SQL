import 'dart:async';
import 'package:blood_donation_sql/models/allotment_model.dart';
import 'package:blood_donation_sql/models/certificate_model.dart';
import 'package:blood_donation_sql/models/diseases_model.dart';
import 'package:blood_donation_sql/models/doctor_model.dart';
import 'package:blood_donation_sql/models/user_model.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('blood_donation.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade1,
    );
  }

  // Future<void> _onUpgrade2(db, oldVersion, newVersion) async {
  //   if (oldVersion < newVersion) {
  //     await db.execute('''
  //     alter table $tableDiseases
  //     drop constraint foreign key {$tableDiseases}_ibfk_1
  //     ''');

  //     await db.execute('''
  //     alter table $tableAllotment
  //     drop constraint foreign key {$tableAllotment}_ibfk_1
  //     ''');

  //     await db.execute('''
  //     alter table $tableCertificate
  //     drop constraint foreign key {$tableCertificate}_ibfk_1
  //     ''');

  //     await db.execute('''
  //     alter table $tableDiseases add foreign key(${Diseasesfields.mis}) 
  //     references $tablestudent(${Diseasesfields.mis}) on delete cascade
  //     ''');

  //     await db.execute('''
  //     alter table $tableAllotment add foreign key(${Allotmentfields.mis}) references $tablestudent(${Allotmentfields.mis})
  //     on delete cascade
  //     ''');

  //     await db.execute('''
  //     alter table $tableCertificate add foreign key(${Certificatefields.mis}) 
  //     references $tablestudent(${Certificatefields.mis}) on delete cascade
  //     ''');

  //   }
  // }

  FutureOr<void> _onUpgrade1(db, oldVersion, newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
          'alter table $tablestudent add name text default name not null');
      await db.execute('''
            CREATE TABLE if not exists $tableDiseases(
              ${Diseasesfields.mis} integer,
              ${Diseasesfields.disease} text,
              primary key(${Diseasesfields.mis}),
              foreign key(${Diseasesfields.mis}) 
              references $tablestudent(${Diseasesfields.mis}) on delete cascade
            )
            ''');

      await db.execute('''
            CREATE TABLE if not exists $tableCertificate(
              ${Certificatefields.mis} integer,
              ${Certificatefields.dateIssued} text not null,  
              primary key(${Certificatefields.mis}),
              foreign key(${Certificatefields.mis}) 
              references $tablestudent(${Certificatefields.mis}) on delete cascade
            )
            ''');
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE if not exists $doctable2(
          ${Doctorfields.id} integer,
          ${Doctorfields.name} text not null,
          ${Doctorfields.age} integer,
          primary key(${Doctorfields.id})
        )
      ''');

      await db.execute('''
        CREATE TABLE if not exists $doctable1(
          ${Doctorfields.bedno} integer,
          ${Doctorfields.id} integer,
          primary key(${Doctorfields.bedno}),
          foreign key(${Doctorfields.id}) 
          references $doctable2(${Doctorfields.id}) on delete cascade
        )
        ''');

      await db.execute('''
        CREATE TABLE if not exists $tablestudent(
        ${Studentfields.mis} integer,
        ${Studentfields.email} text not null,
        ${Studentfields.donated} boolean not null,
        ${Studentfields.bloodGroup} text not null,
        ${Studentfields.certificateGiven} boolean not null,
        ${Studentfields.haemoglobinCount} integer,
        ${Studentfields.weight} integer,
        ${Studentfields.gender} text,

        primary key(${Studentfields.mis})
        )
      ''');

      await db.execute(''' 
        CREATE TABLE if not exists $tableAllotment(
          ${Allotmentfields.mis} integer,
          ${Allotmentfields.bedno} integer,
          ${Allotmentfields.date} text,
          ${Allotmentfields.time} text,
          primary key(${Allotmentfields.mis}),
          foreign key(${Allotmentfields.mis}) 
          references $tablestudent(${Allotmentfields.mis}) on delete cascade,
          foreign key(${Allotmentfields.bedno}) 
          references $doctable1(${Doctorfields.bedno}) on delete cascade
        )
      ''');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  Future create(Doctorinfo doctor) async {
    try {
      final db = await instance.database;

      final json = doctor.toJson();
      await db.rawInsert(
          'insert into $doctable2(${Doctorfields.id}, ${Doctorfields.name}, ${Doctorfields.age}) values(?, ?, ?)',
          [
            json[Doctorfields.id],
            json[Doctorfields.name],
            json[Doctorfields.age]
          ]);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  Future<bool> createStudent(Student std) async {
    try {
      final db = await instance.database;

      final json = std.toJson();
      await db.rawInsert('''
      insert into $tablestudent(
        ${Studentfields.mis}, 
        ${Studentfields.email}, 
        ${Studentfields.name},
        ${Studentfields.donated}, 
        ${Studentfields.bloodGroup}, 
        ${Studentfields.certificateGiven},
        ${Studentfields.haemoglobinCount}, 
        ${Studentfields.weight}, 
        ${Studentfields.gender} )
      values(?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''', [
        json[Studentfields.mis],
        json[Studentfields.email],
        json[Studentfields.name],
        json[Studentfields.donated],
        json[Studentfields.bloodGroup],
        json[Studentfields.certificateGiven],
        json[Studentfields.haemoglobinCount],
        json[Studentfields.weight],
        json[Studentfields.gender]
      ]);
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      return false;
    }
  }

  Future createDisease(Diseases dis) async {
    final db = await instance.database;

    final json = dis.toJson();
    await db.rawInsert('''
      insert into $tableDiseases(${Diseasesfields.mis}, ${Diseasesfields.disease} )
      values(?, ?)
      ''', [json[Diseasesfields.mis], json[Diseasesfields.disease]]);
  }

  Future createDocBed(DoctorAndBed docbed) async {
    try {
      final db = await instance.database;

      final json = docbed.toJson();
      await db.rawInsert(
          'insert into $doctable1(${Doctorfields.bedno}, ${Doctorfields.id}) values(?,?)',
          [json[Doctorfields.bedno], json[Doctorfields.id]]);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  Future<List<Student>> readallStudents() async {
    try {
      final db = await instance.database;

      final result = await db.rawQuery('SELECT * FROM $tablestudent');

      return result.map((json) => Student.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      return [];
    }
  }

  Future<List<Student>> readallDonatedStudents() async {
    try {
      final db = await instance.database;

      final result = await db.rawQuery('''
      SELECT * FROM $tablestudent
      WHERE ${Studentfields.donated} = 1
      ''');

      return result.map((json) => Student.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      return [];
    }
  }

  Future<List<Student>> readallNotDonatedStudents() async {
    try {
      final db = await instance.database;

      final result = await db.rawQuery('''
      SELECT * FROM $tablestudent
      WHERE ${Studentfields.donated} = 0
      ''');

      return result.map((json) => Student.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      return [];
    }
  }

  Future<List<Doctorinfo>> readAllDoctors() async {
    try {
      final db = await instance.database;

      // final orderBy = '${Doctorfields.time} ASC';
      final result = await db.rawQuery('SELECT * FROM $doctable2');

      return result.map((json) => Doctorinfo.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      return [];
    }
  }

  Future<List<DoctorAndBed>> readAllDoctorAndBed() async {
    try {
      final db = await instance.database;

      final result = await db.rawQuery('SELECT * FROM $doctable1');

      return result.map((json) => DoctorAndBed.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      return [];
    }
  }

  Future<void> readAllotment() async{
    try {
      final db = await instance.database;

      final result = await db.rawQuery('SELECT * FROM $tableAllotment');

      print(result);
      // return result.map((json) => AllotmentDetails.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      // return [];
    }
  }

  
  Future<String> getDoctorForStudent(int bedno) async{
    final db = await instance.database;

    final result = await db.rawQuery(''' 
    SELECT ${Doctorfields.name}
    FROM $doctable2
    WHERE ${Doctorfields.id} = ( 
    SELECT DISTINCT(${Doctorfields.id})
    FROM $doctable1
    WHERE ${Doctorfields.bedno} = ?)
    ''',
    [bedno]);

    if(result.isEmpty) return 'Not assigned';
    

    return result[0][Doctorfields.name].toString();
  }

  Future readForeignKeys() async {
    final db = await instance.database;

    final result = await db.rawQuery('''
                  SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
                  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                  WHERE TABLE_NAME=$tableDiseases;
                  ''');
    print(result.toString());
  }

  Future<int> updatedoc(int id, String newname) async {
    final db = await instance.database;

    return await db.rawUpdate(
        'update $doctable2 set ${Doctorfields.name} = ? where ${Doctorfields.id} = ?',
        [newname, id]);
  }


  Future<int?> numberOfStudents() async {
    final db = await instance.database;

    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tablestudent'));
  }

  Future updateDonatedStatus(int mis) async {
    final db = await instance.database;

    await db.rawUpdate('''
      UPDATE $tablestudent
      SET ${Studentfields.donated} = 1
      WHERE ${Studentfields.mis} = $mis
      ''');
  }

  Future deleteStudent(int mis) async{
    final db = await instance.database;

    await db.rawDelete('''
    DELETE FROM $tablestudent
    WHERE ${Studentfields.mis} = ?
    ''',
    [mis]);
  }

  Future deleteAllStudents() async {
    final db = await instance.database;

    await db.execute('delete from $tablestudent');
  }
// see delete
  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  Future<void> deletedoctors() async {
    final db = await instance.database;

    await db.execute('''
      delete from $doctable1
    ''');
  }

  Future<void> deletediseasess() async {
    final db = await instance.database;

    await db.execute('''
      delete from $tableDiseases
    ''');
  }

  Future<void> showTables() async {
    final db = await instance.database;

    //  var res = await db.execute('show tables');
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });
  }

  Future<bool> checkDonatedStatus(int mis) async {
    final db = await instance.database;

    final res = await db.rawQuery('''
      select ${Studentfields.donated}
      from $tablestudent
      where ${Studentfields.mis} = $mis
      ''');
    if (res[0]['donated'] == '1') return true;
    return false;
  }

  Future<bool> checkUserPresent(String? email) async {
    final db = await instance.database;
    if (email == null) {
      return false;
    }
    final result = await db.rawQuery('''
      SELECT * FROM $tablestudent
      WHERE ${Studentfields.email} = ?
      ''',
      [email]
      );

    return result.isEmpty == true ? false : true;
  }

  Future<int> getMis(String email) async{
    final db = await instance.database;

    final result = await db.rawQuery('''
    SELECT ${Studentfields.mis}
    FROM $tablestudent
    WHERE ${Studentfields.email} = ?
    ''',
    [email]);

    return int.parse(result[0][Studentfields.mis].toString());
  }

  Future<String> getBednum(String email) async{
    final db = await instance.database;

    final result = await db.rawQuery('''
    SELECT *
    FROM $tableAllotment
    '''); 
    if(result.isEmpty) return "Not assigned";

    int mis = await getMis(email);

    String bednum = "Not alloted";
    for(int i=0; i<result.length; i++){
      var list = result[i];
      for (String key in list.keys){
        if(key == "mis" && list[key] == mis){
            bednum = list[Allotmentfields.bedno].toString();
        }
      }
    }
    return bednum;
    // return result[0][Allotmentfields.bedno].toString();
  }

  Future allotSlot(int mis) async {
    String hrs = "0", mins = "0";
    int bed = 0;
    int? nTmp = await numberOfStudents();
    int n = 0;
    print("nTmp = $nTmp");
    if(nTmp != null){
      n = nTmp;
    }
    print("$mis: $n");
    // if(n <= 120){
    hrs = (10 + (n ~/ 60)).toString();

    if (n % 60 == 0) {
      mins = "00";
      // hrs = (int.parse(hrs) + 1).toString();
    } else {
      mins = (((n % 60) ~/ 20) * 20).toString();
    }
    if(mins.length == 1){
      String tmp = mins;
      mins = "";
      mins += "0";
      mins += tmp;
    }
    // as n is already +1, coz allotSlot is done after creating student
    if ((n ) % 20 == 0) {
      bed = 20;
    } else {
      bed = ((n ) % 20);
    }

    String tmp = "";
    tmp += hrs;
    tmp += ":";
    tmp += mins;

    final db = await instance.database;
    print("mis = $mis, n = $n, bed = $bed, time = $tmp");
    // final json = AllotmentDetails.toJson();
    try {
      await db.rawInsert('''
      INSERT INTO $tableAllotment(${Allotmentfields.mis}, ${Allotmentfields.bedno},
      ${Allotmentfields.date}, ${Allotmentfields.time})
      VALUES(?, ?, ?, ?)
      ''', [mis, bed, '11-11-2022', tmp]);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  Future<String> getTime(String email) async{
    final db = await instance.database;

    final result = await db.rawQuery('''
    SELECT ${Allotmentfields.time}
    FROM $tableAllotment
    WHERE ${Allotmentfields.mis} = (
      SELECT ${Allotmentfields.mis}
      FROM $tablestudent
      WHERE ${Studentfields.email} = ?
    )
    ''',
    [email]);

    if(result.isEmpty) return "Not alloted";

    return result[0][Allotmentfields.time].toString();
  }


}
