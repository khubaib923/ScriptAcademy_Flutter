import 'package:bloc_project/phone_auth_cubit/cubit/auth_cubit.dart';
import 'package:bloc_project/phone_auth_cubit/cubit/auth_state.dart';
import 'package:bloc_project/phone_auth_cubit/screen/signin_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is AuthLoggedOutState){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignInPhoneScreen()));
              }
            },
            builder: (context, state) {
              return IconButton(onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout();

              }, icon: const Icon(Icons.logout));
            },
          )
        ],
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
