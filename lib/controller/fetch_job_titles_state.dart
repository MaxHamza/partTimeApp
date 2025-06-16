part of 'fetch_job_titles_cubit.dart';

sealed class FetchJobTitlesState {}

final class FetchJobTitlesInitial extends FetchJobTitlesState {}
final class FetchJobTitlesLoading extends FetchJobTitlesState {}
final class FetchJobTitlesSuccess extends FetchJobTitlesState {
  final List<String> jobTitles;
  FetchJobTitlesSuccess(this.jobTitles);
}
final class FetchJobTitlesFailure extends FetchJobTitlesState {
  final String message;
  FetchJobTitlesFailure(this.message);
}