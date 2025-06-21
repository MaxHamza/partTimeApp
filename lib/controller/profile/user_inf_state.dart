part of 'user_inf_cubit.dart';


sealed class UserInfState {}

final class UserInfInitial extends UserInfState {}
final class UserInfLoading extends UserInfState {}
final class UserInfFailure extends UserInfState {
  final String message;
  UserInfFailure(this.message);
}
final class UserInfSuccess extends UserInfState {
 final User user;
  UserInfSuccess(this.user);
}