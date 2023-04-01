import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hive_database/notes_app/boxes/boxes.dart';
import 'package:flutter_hive_database/notes_app/model/notes_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          myDialogueBox();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> myDialogueBox()async{
     await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("Add Notes"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Title"
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Description"
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Cancel")),
              TextButton(onPressed: (){
                NotesModel notes=NotesModel(title: titleController.text, description: descriptionController.text);
                final box=Boxes.getData();
                box.add(notes);
                notes.save();
                titleController.clear();
                descriptionController.clear();
                log(box.getAt(8)!.title.toString());
              }, child: const Text("Add")),
            ],
          );
        }
    );
  }
}
