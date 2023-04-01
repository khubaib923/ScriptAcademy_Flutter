import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget/sqflite_datebase/database_helper.dart';

class SqfliteScreen extends StatefulWidget {
  const SqfliteScreen({Key? key}) : super(key: key);

  @override
  State<SqfliteScreen> createState() => _SqfliteScreenState();
}

class _SqfliteScreenState extends State<SqfliteScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sqflite Example"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()async{
              int id=await DatabaseHelper.instance.insert({
                DatabaseHelper.columnName:"Khubaib"
              });
            if(kDebugMode){
              print("the inserted id is $id");
            }
            },style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange)
            ),
              child:  const Text("Insert"),
            ),
            ElevatedButton(onPressed: () async{
             List<Map<String,dynamic>> queryRows= await DatabaseHelper.instance.queryAll();
             if(kDebugMode){
               print(queryRows);
             }
            },style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)
            ),
              child:  const Text("Query"),
            ),
            ElevatedButton(onPressed: ()async{
             int updatedId=await DatabaseHelper.instance.update({
                DatabaseHelper.columnId:12,
                DatabaseHelper.columnName:"Uzair"
              });
             if(kDebugMode){
               print("the updatedId is $updatedId");
             }
            },style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)
            ),
              child:  const Text("Update"),
            ),
            ElevatedButton(onPressed: () async{
              int deletedId=await DatabaseHelper.instance.delete(2);
              if(kDebugMode){
                print("the deletedId is $deletedId");
              }

            },style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pinkAccent)
            ),
              child:  const Text("Delete"),
            ),


          ],
        ),
      ),
    );
  }
}
