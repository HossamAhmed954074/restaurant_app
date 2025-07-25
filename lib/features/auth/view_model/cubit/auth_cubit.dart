import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:meta/meta.dart';

import '../../../../core/errors/firebase_faliure.dart';
import '../../../../core/services/auth_services.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authServices) : super(AuthInitial());
  AuthServicess authServices;

  register({required String email, required String password,required String name})async{
    emit(AuthLoading());
    try {
      await authServices.registerUser(email: email, password: password, name: name);
      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
      emit(AuthFailure(FirebaseFaliure(e.code)));
    }
  }

  logIn({required String email, required String password})async{
    emit(AuthLoading());
    try {
      await authServices.loginUser(email: email, password: password);
      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
      emit(AuthFailure(FirebaseFaliure(e.code)));
    }
  }

  resetPassword({required String email})async{
    emit(AuthLoading());
    try {
      await authServices.resetPassword(email);
      emit(AuthSuccess());
    }on FirebaseAuthException catch(e){
      emit(AuthFailure(FirebaseFaliure(e.code)));
    }
  }




}
