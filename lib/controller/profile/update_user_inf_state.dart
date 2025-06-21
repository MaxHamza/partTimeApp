part of 'update_user_inf_cubit.dart';


sealed class UpdateUserInfState {}

final class UpdateUserInfInitial extends UpdateUserInfState {}
final class UpdateUserInfLoading extends UpdateUserInfState {}
final class UpdateUserInfSuccess extends UpdateUserInfState {}
final class UpdateUserInfFailure extends UpdateUserInfState {
  final String message;
  UpdateUserInfFailure(this.message);
}