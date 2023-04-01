import 'package:bloc_project/generated_route/cubit/first_Screen_cubit.dart';
import 'package:bloc_project/generated_route/screen/first_screen.dart';
import 'package:bloc_project/phone_auth_cubit/cubit/auth_cubit.dart';
import 'package:bloc_project/phone_auth_cubit/cubit/auth_state.dart';
import 'package:bloc_project/phone_auth_cubit/screen/signin_phone.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'generated_route/route/routes.dart';
import 'phone_auth_cubit/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => AuthCubit(),
    //   child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       title: 'Flutter Demo',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: BlocBuilder<AuthCubit,AuthState>(
    //         buildWhen: (oldState,newState){
    //           return oldState is AuthInitialState;
    //         },
    //         builder: (context, state) {
    //           if(state is AuthLoggedInState){
    //             return const HomeScreen();
    //           }
    //          else if(state is AuthLoggedOutState){
    //             return const SignInPhoneScreen();
    //           }
    //          else{
    //            return const Scaffold();
    //           }
    //         },
    //       )
    //   ),
    // );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: FirstScreen(),
      onGenerateRoute: Routes.generatedRoute,
      initialRoute: "/first",
    );
  }
}




