part of 'get_applications_cubit.dart';


sealed class GetApplicationsState {}

final class GetApplicationsInitial extends GetApplicationsState {}
final class GetApplicationsLoading extends GetApplicationsState {}
final class GetApplicationsSuccess extends GetApplicationsState {
 final List<ApplicationModel>? applys;
 GetApplicationsSuccess(this.applys);
}
final class GetApplicationsFailure extends GetApplicationsState {
  final String message;
  GetApplicationsFailure(this.message);
}