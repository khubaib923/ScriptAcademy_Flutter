import 'package:api_provider_mvvm_architecture/utils/route/route_name.dart';
import 'package:api_provider_mvvm_architecture/view/home_screen.dart';
import 'package:api_provider_mvvm_architecture/view/login_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context)=>const LoginScreen());

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context)=>const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context)=>const Scaffold(body: Center(child: Text("No route defined"),),));
    }

  }
}