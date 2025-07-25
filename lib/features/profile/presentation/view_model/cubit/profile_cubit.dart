import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:resturant_app/core/errors/firebase_faliure.dart';

import 'package:resturant_app/core/services/auth_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.auth) : super(ProfileInitial());

  final AuthServicess auth;

  logOut() async {
    await auth.signOut();
  }

  resetPasswordWithEmail({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ProfileReSetPassowrdLoading());
    try {
      await auth.resetPasswordFromCurrentPassword(
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      emit(ProfileResetPassowrdSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ProfileReSetPassowrdFailure(FirebaseFaliure(e.code)));
    }
  }

  resetUserName({required String newUserName}) async {
    emit(ProfileResetUserNameLoading());
    try {
      await auth.updateUserName(name: newUserName);
      emit(ProfileResetUserNameSuccess());
    } on FirebaseException catch (e) {
      emit(ProfileResetUserNameFailure(FirebaseFaliure(e.code)));
    }
  }

  deleteAccount({required String email, required String password}) async {
    emit(ProfileDeleteAccountLoading());
    try {
      await auth.deleteAccount(email: email, password: password);
      emit(ProfileDeleteAccountSuccess());
    } on FirebaseException catch (e) {
      emit(ProfileDeleteAccountFailure(FirebaseFaliure(e.code)));
    }
  }
}
