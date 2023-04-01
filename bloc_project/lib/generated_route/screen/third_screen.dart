import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/third_screen_cubit.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third Screen"),
        centerTitle: true,
      ),
      body:BlocBuilder<ThirdScreenCubit, int>(
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
          BlocProvider.of<ThirdScreenCubit>(context).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}