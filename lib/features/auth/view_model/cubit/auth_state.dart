part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthSuccess extends AuthState {}
final class AuthFailure extends AuthState {
  // final FirebaseFaliure message;
  // AuthFailure(this.message);
}

final class GoogleAuthFailure extends AuthState {
  final String message;
  GoogleAuthFailure(this.message);
}

