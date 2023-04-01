

import 'package:bloc_project/phone_auth_cubit/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  const VerifyPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify Phone Number",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              maxLength: 6,
              controller: otpController,
              decoration: InputDecoration(
                  hintText: "6 Digit OTP",
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if(state is AuthLoggedInState){
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                }
                else if(state is AuthErrorState){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage.toString()),backgroundColor:Colors.red ,duration: const Duration(seconds: 2),));
                }
              },
              builder: (context, state) {
                if(state is AuthLoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }

                return CupertinoButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).verifyOtp(otpController.text.trim());
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: const Text("Verify"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
