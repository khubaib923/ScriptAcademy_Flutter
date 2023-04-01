import 'package:bloc_project/phone_auth_cubit/cubit/auth_cubit.dart';
import 'package:bloc_project/phone_auth_cubit/cubit/auth_state.dart';
import 'package:bloc_project/phone_auth_cubit/screen/verify_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPhoneScreen extends StatelessWidget {
  const SignInPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In with Phone",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              maxLength: 11,
              controller: phoneNumberController,
              decoration: InputDecoration(
                  hintText: "Phone Number",
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is AuthCodeSentState){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const VerifyPhoneNumberScreen()));
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
                    final String phoneNumber = "+92${phoneNumberController.text.trim()}";
                    BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: const Text("Sign In"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
