import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databasename="person.db";
  static final _version=1;
  static final _table="my_table";

  static final columnId='id';
  static final columnName='name';
  static final columnAge='age';

  static Database? _database;

  //ek j instance banave multiple instance na kare
  DatabaseHelper._privateconstructor();
  static final DatabaseHelper instance=DatabaseHelper._privateconstructor();


  Future<Database> get database async{
    if(_database!=null) return _database!;

    _database=await _initDatabase();
    return _database!;
  }
  _initDatabase() async{
    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,_databasename);
    return await openDatabase(path,version: _version,onCreate: _oncreate);
  }

  Future _oncreate(Database db,int version) async{
    await db.execute('''
     CREATE TABLE $_table(
     $columnId INTEGER PRIMARY KEY,
     $columnName TEXT NOT NULL,
     $columnAge INTEGER NOT NULL
     )
    ''');
  }

  //insert
Future<int> insert(Map<String,dynamic> row) async{
    Database db=await instance.database;
    return await db.insert(_table, row);
}

//queryall
Future<List<Map<String,dynamic>>> query() async{
  Database db=await instance.database;
    return await db.query(_table);
}

//queryspecific
  Future<List<Map<String,dynamic>>> queryspecific(int age) async {
    Database db=await instance.database;
  //  var res=await db.query(_table,where: "age == ?",whereArgs: [age]);
    var res=await db.rawQuery("SELECT * FROM $_table WHERE age ==?",[age]);
    return res;
  }

  //delete
Future<int> deletedata(int id)async{
  Database db=await instance.database;
  var res=await db.delete(_table,where: "id=?",whereArgs: [id]);
  return res;
}


//update
  Future<int> update(int id)async{
    Database db=await instance.database;
    var res=await db.update(_table,{"$columnName":"nirav","$columnAge":23},where: "id = ?",whereArgs: [id]);
    return res;
  }

}