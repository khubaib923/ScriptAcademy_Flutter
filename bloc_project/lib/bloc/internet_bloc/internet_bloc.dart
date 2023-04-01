// import 'dart:async';
//
// import 'package:bloc_project/cubit/internet_bloc/internet_event.dart';
// import 'package:bloc_project/cubit/internet_bloc/internet_state.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class InternetBloc extends Bloc<InternetEvent,InternetState>{
//   final Connectivity _connectivity=Connectivity();
//   StreamSubscription? connectivitySubscription;
//   InternetBloc():super(InternetInitialState()){
//     on<InternetLossEvent>((event, emit) => emit(InternetLossState()));
//     on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));
//
//     connectivitySubscription=_connectivity.onConnectivityChanged.listen((result) {
//       if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){
//         add(InternetGainedEvent());
//       }
//       else{
//         add(InternetLossEvent());
//       }
//     });
//   }
//   @override
//   Future<void> close() {
//     connectivitySubscription!.cancel();
//     return super.close();
//   }
//
//
//
//
//
// }