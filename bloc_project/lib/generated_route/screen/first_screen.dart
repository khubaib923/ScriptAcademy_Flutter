import 'package:bloc_project/generated_route/cubit/first_Screen_cubit.dart';
import 'package:bloc_project/generated_route/cubit/second_screen_cubit.dart';
import 'package:bloc_project/generated_route/screen/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, "/second",arguments: {
              "title":"khubaib"
            });
          }, icon: const Icon(Icons.keyboard_arrow_right))
        ],
        centerTitle: true,
      ),
      body: BlocBuilder<FirstScreenCubit, int>(
        builder: (context, state) {
          return Center(
            child: Text(state.toString(),
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<FirstScreenCubit>(context).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
