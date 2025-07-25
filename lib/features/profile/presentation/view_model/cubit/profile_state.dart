part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}




final class ProfileResetPassowrdSuccess extends ProfileState{}
final class ProfileReSetPassowrdFailure extends ProfileState{
   final FirebaseFaliure message;
  ProfileReSetPassowrdFailure(this.message);
}
final class ProfileReSetPassowrdLoading extends ProfileState{}




final class ProfileResetUserNameSuccess extends ProfileState{}
final class ProfileResetUserNameLoading extends ProfileState{}
final class ProfileResetUserNameFailure extends ProfileState{
  final FirebaseFaliure message;
  ProfileResetUserNameFailure(this.message);
}



final class ProfileDeleteAccountSuccess extends ProfileState{}
final class ProfileDeleteAccountFailure extends ProfileState{
  final FirebaseFaliure message;
  ProfileDeleteAccountFailure(this.message);
}
final class ProfileDeleteAccountLoading extends ProfileState{}