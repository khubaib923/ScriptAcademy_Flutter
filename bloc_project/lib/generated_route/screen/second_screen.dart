import 'package:bloc_project/generated_route/cubit/second_screen_cubit.dart';
import 'package:bloc_project/generated_route/cubit/third_screen_cubit.dart';
import 'package:bloc_project/generated_route/screen/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatelessWidget {
  final String title;
  const SecondScreen({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title.toString()),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, "/third");
          }, icon: const Icon(Icons.keyboard_arrow_right))
        ],
      ),
      body: BlocBuilder<SecondScreenCubit, int>(
        builder: (context, state) {
          return Center(
            child: Text(state.toString(),
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          BlocProvider.of<SecondScreenCubit>(context).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}