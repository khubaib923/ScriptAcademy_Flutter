// ignore_for_file: recursive_getters

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper{

  static const _dbName="myDatabase.db";
  static  const  _dbVersion=1;
  static const _tableName="myTable";
  static const  columnId="_id";
  static const  columnName="name";

  DatabaseHelper._privateConstructor();
  //making it a singleton class
  static final DatabaseHelper instance=DatabaseHelper._privateConstructor();

  factory DatabaseHelper(){
   return instance;
  }

  //initialize the database

static Database? _database;

  Future<Database?> get database async{

    if(_database!=null){
      return _database;
    }
    _database=await _initiateDatabase();
    return _database;
  }


Future<Database> _initiateDatabase() async{
    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,_dbName);
     return await openDatabase(path,version: _dbVersion,onCreate: _onCreate);




}

Future<void> _onCreate(Database db,int version) async{

 db.execute(
  '''
  CREATE TABLE $_tableName ($columnId INTEGER PRIMARY KEY,
  $columnName TEXT NOT NULL)
  '''
) ;


}


// {
//   "_id":12,
//    "name":"Khubaib",
// }


Future<int> insert(Map<String,dynamic>row)async{
    Database? db=await instance.database;
    return await db!.insert(_tableName, row);
  }


Future<List<Map<String,dynamic>>>  queryAll() async{
    Database? db=await instance.database;
    return await db!.query(_tableName);

}

Future<int> update(Map<String,dynamic>row) async{
  Database? db=await instance.database;
  int id=row[columnId];
  return await db!.update(_tableName, row,where:"$columnId = ? ",whereArgs: [id]);


}


Future<int>delete(int id)async{
    Database? db=await instance.database;
   return await  db!.delete(_tableName,where: "$columnId = ?",whereArgs: [id]);
}





}