part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

// Initial states
final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileRefreshSuccess extends ProfileState {}

final class ProfileLogoutSuccess extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final FirebaseFailure message;
  ProfileFailure(this.message);
}

// Password reset states
final class ProfileResetPasswordSuccess extends ProfileState {}

final class ProfileResetPasswordFailure extends ProfileState {
  final FirebaseFailure message;
  ProfileResetPasswordFailure(this.message);
}

final class ProfileResetPasswordLoading extends ProfileState {}

// Username update states
final class ProfileResetUserNameSuccess extends ProfileState {}

final class ProfileResetUserNameLoading extends ProfileState {}

final class ProfileResetUserNameFailure extends ProfileState {
  final FirebaseFailure message;
  ProfileResetUserNameFailure(this.message);
}

// Account deletion states
final class ProfileDeleteAccountSuccess extends ProfileState {}

final class ProfileDeleteAccountFailure extends ProfileState {
  final FirebaseFailure message;
  ProfileDeleteAccountFailure(this.message);
}

final class ProfileDeleteAccountLoading extends ProfileState {}
