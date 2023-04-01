import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              // border: OutlineInputBorder()
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)
              )
            ),
          ),
          TextFormField(),
          SizedBox(height: MediaQuery.of(context).size.height*0.07,),
          CircleAvatar(
            radius: 100,
            //backgroundColor: Colors.black,
            //child: Icon(Icons.person),
            backgroundImage: NetworkImage('https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?cs=srgb&dl=pexels-tu%E1%BA%A5n-ki%E1%BB%87t-jr-1382731.jpg&fm=jpg'),
          )
        ],
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple
              ),
                currentAccountPicture: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?cs=srgb&dl=pexels-tu%E1%BA%A5n-ki%E1%BB%87t-jr-1382731.jpg&fm=jpg'),
                ),
                accountName: Text("Khubaib"), accountEmail: Text("khubaibirfan199@gmail.com")),
            ListTile(
              title: Text("Email"),
               subtitle: Text("Enter"),
               leading: Icon(Icons.mail),
              trailing: Icon(Icons.visibility),
            )
          ],
        ),
      ),
    );
  }
}
