import 'dart:io';

import 'package:flutter_widget/shopping_cart/card_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import "package:path/path.dart";

class DbHelper{
  DbHelper._privateConstructor();

  static final DbHelper instance=DbHelper._privateConstructor();
  static const _dbName="cart.db";
  static  const  _dbVersion=1;
  static const _tableName="cart";
  // static const  columnId="_id";
  // static const  columnName="name";

  factory DbHelper(){
    return instance;
  }

  static Database? _database;
  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }
    _database=await _initializedDatabase();
    return _database;

  }

  Future<Database> _initializedDatabase()async{

    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,_dbName);
    return await openDatabase(path,version: _dbVersion,onCreate: _onCreate);


  }
  Future<void> _onCreate(Database db,int version) async{

    await db.execute(
      '''
      CREATE TABLE  $_tableName  (
      id INTEGER PRIMARY KEY,
      productId VARCHAR UNIQUE,
      productName TEXT,
      initialPrice INTEGER,
      productPrice INTEGER,
      quantity INTEGER,
      unitTag TEXT,
      image TEXT
      
      
      )
'''
    );
  }

  Future<Cart>insert(Cart cart)async{
    Database? db=await instance.database;
     await db!.insert(_tableName, cart.toMap());
     return cart;
  }

  Future<List<Cart>>getCartList()async{
    Database? db=await instance.database;
    List<Map<String,Object?>> queryResult=await db!.query(_tableName);
    return  queryResult.map((e) =>Cart.fromMap(e)).toList();



  }

  Future<int>deleteItem(int id)async{
    Database? db=await instance.database;
   return await db!.delete(_tableName,where: 'id = ?',whereArgs: [id]);




  }

  Future<int>updateItem(Cart cart)async{
    Database? db=await instance.database;
    return await db!.update(_tableName, cart.toMap(),where: " id = ? ",whereArgs: [cart.id]);




  }

}