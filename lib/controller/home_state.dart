part of 'home_cubit.dart';

sealed class HomeState {}
final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {
  final List<Jobs> opportunities;
  final List<Jobs>filteredJobs;
  HomeSuccess(this.opportunities, [List<Jobs>? filtered])
      : filteredJobs = filtered ?? opportunities;
}
final class HomeFailure extends HomeState {
  final String message;
  HomeFailure(this.message);
}