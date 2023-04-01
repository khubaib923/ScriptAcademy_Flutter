import 'package:bloc_project/generated_route/cubit/first_Screen_cubit.dart';
import 'package:bloc_project/generated_route/cubit/third_screen_cubit.dart';
import 'package:bloc_project/generated_route/screen/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/second_screen_cubit.dart';
import '../screen/second_screen.dart';
import '../screen/third_screen.dart';

class Routes {
  static Route generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/first":
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => FirstScreenCubit(),
              child: const FirstScreen(),
            ));
      case "/second":
        Map<String,dynamic>arguments=settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => SecondScreenCubit(),
              child:  SecondScreen(title: arguments["title"],),
            ));

      case "/third":
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => ThirdScreenCubit(),
              child: const ThirdScreen(),
            ));
      default:
        return MaterialPageRoute(builder: (context)=>const Scaffold());

    }
  }
}