import 'package:bloc_project/form%20_validation/bloc/signin_bloc.dart';
import 'package:bloc_project/form%20_validation/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Example",style: TextStyle(fontSize: 40,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),),
            const SizedBox(height: 200,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(
              create: (context) => SignInBloc(),
              child: const SigninScreen(),
             )));
            }, child: const Text("Sign in with Email")),
            ElevatedButton(onPressed: (){}, child:const Text("Sign in with Google"))

          ],
        ),
      ),
    );
  }
}
