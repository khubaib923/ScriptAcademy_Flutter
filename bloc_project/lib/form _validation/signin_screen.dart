import 'package:bloc_project/form%20_validation/bloc/signin_bloc.dart';
import 'package:bloc_project/form%20_validation/bloc/signin_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/signin_state.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 10,),
            TextField(
              onChanged: (value){
                BlocProvider.of<SignInBloc>(context).add(
                  SignInTextChangedEvent(emailController.text,passwordController.text)
                );
              },
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: "Email Address"
              ),
            ),
            TextField(
              onChanged: (value){
                BlocProvider.of<SignInBloc>(context).add(
                  SignInTextChangedEvent(emailController.text,passwordController.text)
                );
              },
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: "Password"
              ),
            ),
            const SizedBox(height: 40,),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if(state is SignInLoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return CupertinoButton(
                    onPressed: () {
                      if(state is SignInValidState){
                        BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(emailController.text, passwordController.text)
                        );
                      }
                    },
                    color: (state is SignInValidState)?Colors.blue:Colors.grey,
                    child: const Center(child: Text("Sign in")));
              },
            )
          ],
        ),
      ),
    );
  }
}
