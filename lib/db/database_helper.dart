import 'package:blood_donation_sql/models/doctor_model.dart';
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

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE doctor(
        ${Doctorfields.id} integer primary key autoincrement,
        ${Doctorfields.age} integer,
        ${Doctorfields.bedno} integer,
        ${Doctorfields.name} text
      )
''');
  }

  Future create(Doctor doctor) async {
    final db = await instance.database;

    final json = doctor.toJson();
    await db.rawInsert(
        'insert into doctor(${Doctorfields.id}, ${Doctorfields.age}, ${Doctorfields.bedno}, ${Doctorfields.name}) values(?, ?, ?, ?)', [json[Doctorfields.
        id], json[Doctorfields.age], json[Doctorfields.bedno], json[Doctorfields.name] ]);
  }

  Future<List<Doctor>> readAllDoctors() async {
    final db = await instance.database;

    // final orderBy = '${Doctorfields.time} ASC';
    final result = await db.rawQuery('SELECT * FROM doctor');

    return result
        .map((json) => Doctor
            .fromJson(json))
        .toList();
  }

  Future<int> updatedoc(int id, String newname) async{
    final db = await instance.database;

    return await db.rawUpdate(
      'update doctor set ${Doctorfields.name} = ? where ${Doctorfields.id} = ?',
      [newname, id]
    );
  }


  
// see delete
  Future<void> deleteDatabase(String path) => databaseFactory.deleteDatabase(path);

  Future<void> deletedoctors() async{
    final db = await instance.database;

    await db.execute('''
      drop table doctor
''');
  }


}
