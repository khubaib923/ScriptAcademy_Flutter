import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: Hive.openBox("khubaib"),
                builder:(context,AsyncSnapshot<Box> snapshot){
                  if(snapshot.hasData){
                    return ListTile(
                      title: Text(snapshot.requireData.get("name").toString()),
                      subtitle: Text(snapshot.requireData.get("age").toString()),
                      trailing: IconButton(
                        onPressed: (){
                          snapshot.requireData.put("name", "altaf");
                          snapshot.requireData.put("age", 24);
                          setState(() {});
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      leading: IconButton(
                        onPressed: (){
                          snapshot.requireData.delete("age");
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  }
                  else{
                    return const Text("loading");
                  }
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var box = await Hive.openBox("khubaib"); // filename
          box.put("name", "khubaib");
          box.put("name", "uzair");
          box.put("age", 22);
          box.put("detail", {
            "name":"altaf",
            "passion":"developer"
          });
          log(box.get("name"));
          log(box.get("age").toString());
          log(box.get("detail")["passion"].toString());
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
