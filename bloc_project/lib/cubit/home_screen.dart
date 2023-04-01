import 'package:bloc_project/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_project/bloc/internet_bloc/internet_state.dart';
import 'package:bloc_project/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: BlocConsumer<InternetCubit,InternetState>(
                listener: (context, state) {
                  if(state == InternetState.gained){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Internet connected!"),backgroundColor: Colors.green,));
                  }
                  else if(state == InternetState.lost){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Internet not connected!"),backgroundColor: Colors.red,));
                  }

                },
                builder: (context, state) {
               if(state == InternetState.gained){
                   return const Text("Connected!");
               }
              else if(state == InternetState.lost){
               return const Text("Not connected!");
              }
              else{
              return const Text("loading...");
              }

                },
              )
          )
      ),
    );
  }
}


