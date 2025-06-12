part of 'signup_cubit.dart';


sealed class SignupState {}

final class SignupInitial extends SignupState {}
final class SignupSuccess extends SignupState {}
final class SignupFailure extends SignupState {
  final String message;
  SignupFailure(this.message);
}
final class SignupLoading extends SignupState {}
