import 'package:bigcart/screens/app_login.dart';
import 'package:flutter/material.dart';
import '../screens/app_about.dart';
import '../screens/contact_us.dart';
import '../state/state.dart';
import 'package:http/http.dart' as http;

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isLoading = false;
  String? error;
  @override
  Widget build(BuildContext context) {
    var myAppState = MyInheritedWidget.of(context);
    return  ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(
              color: Color(0xFF6CC51D)
          ),
          accountName: const Text("New User", style: TextStyle(
            fontFamily: "Poppins",
          ),), accountEmail: Text(myAppState?.userData?.email ?? "", style: const TextStyle(
            fontFamily: "Poppins"
        ),),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("images/profile_avatar.png"),
          ),
        ),
        ListTile(
          onTap: (){
            Navigator.of(context).pop();
          },
          leading: const Icon(Icons.home, color: Color(0xFF6CC51D),),
          title: const Text("HomePage", style: TextStyle(fontFamily: "Poppins"),),
        ),
        ListTile(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ContactScreen()));
          },
          leading: const Icon(Icons.phone, color: Color(0xFF6CC51D)),
          title: const Text("Contact Us", style: TextStyle(fontFamily: "Poppins"),),
        ),
        ListTile(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AboutScreen()));
          },
          leading: const Icon(Icons.info, color: Color(0xFF6CC51D)),
          title: const Text("About Us", style: TextStyle(fontFamily: "Poppins"),),
        ),
        const ListTile(
          leading: Icon(Icons.shopping_cart, color: Color(0xFF6CC51D)),
          title: Text("Order Details", style: TextStyle(fontFamily: "Poppins"),),
        ),
        !isLoading?ListTile(
          onTap: ()async{
            await logout(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> LoginScreen()));
          },
          leading: const Icon(Icons.exit_to_app, color: Color(0xFF6CC51D)),
          title: const Text("Logout", style: TextStyle(fontFamily: "Poppins"),),
        ): const Center(child: CircularProgressIndicator())
      ],
    );
  }

  Future<void> logout(BuildContext context)async{
    var url = Uri.parse('http://ishaqhassan.com:2000/user/signout');
    var myAppState = MyInheritedWidget.of(context);
    setState(() {
      isLoading = true;
    });
    try{
      if(myAppState?.userData != null){
        await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userData?.accessToken}"});
      }else{
        await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userSignUpData?.accessToken}"});
      }
    }catch(e){
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
