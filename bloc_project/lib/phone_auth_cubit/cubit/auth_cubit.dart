import 'package:bloc_project/phone_auth_cubit/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  AuthCubit():super(AuthInitialState()){
    User? currentUser=_auth.currentUser;
    if(currentUser!=null){
      emit(AuthLoggedInState(currentUser));
    }
    else{
      emit(AuthLoggedOutState());
    }
  }
  String? _verificationId;

  void sendOtp(String phoneNumber)async{
    emit(AuthLoadingState());
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential){
          // signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error){
          emit(AuthErrorState(error.message.toString()));
        },
        codeSent:(verificationId,forceResendingToken){
          _verificationId=verificationId;
          emit(AuthCodeSentState());
        } ,
        codeAutoRetrievalTimeout: (verificationId){
          _verificationId=verificationId;
        }
    );

  }

  void verifyOtp(String otp)async{
    emit(AuthLoadingState());
    PhoneAuthCredential phoneAuthCredential=PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(phoneAuthCredential);

  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential)async{
    try{
      UserCredential userCredential=await _auth.signInWithCredential(phoneAuthCredential);
      if(userCredential.user!=null){
        emit(AuthLoggedInState(userCredential.user!));
      }
    }
    on FirebaseAuthException catch(e){
      emit(AuthErrorState(e.message.toString()));
    }

  }

  void logout() async{
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }





}