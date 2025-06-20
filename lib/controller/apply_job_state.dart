part of 'apply_job_cubit.dart';


sealed class ApplyJobState {}

final class ApplyJobInitial extends ApplyJobState {}
final class ApplyJobLoading extends ApplyJobState {}
final class ApplyJobFailure extends ApplyJobState {
  final String message;
  ApplyJobFailure(this.message);
}
final class ApplyJobSuccess extends ApplyJobState {
  final ApplicationModel? app;
  ApplyJobSuccess(this.app);
}
