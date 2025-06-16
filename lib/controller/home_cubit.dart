import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/jobs.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SharedPreferences prefs;

  HomeCubit(this.prefs) : super(HomeInitial());
  List<Jobs> _allJobs = [];

  Future<void> fetchJobOpportunities() async {
    emit(HomeLoading());
    try {
      final response = await http.get(
        Uri.parse(
          'http://192.168.1.17:7882/part-time-app/public/api/jobOpportunities',
        ),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        final opportunities = data.map((json) => Jobs.fromJson(json)).toList();
        _allJobs = opportunities;
        emit(HomeSuccess(_allJobs, _allJobs));
      } else {
        emit(HomeFailure('Failed to load data: ${response.statusCode}'));
      }
    } catch (e) {
      emit(HomeFailure('Error: $e'));
    }
  }

  void searchJobs({String? name}) {
    if (state is HomeSuccess) {
      final filtered =
          _allJobs.where((job) {
            final matchesName =
                name == null ||
                job.jobTitle.toLowerCase().contains(name.toLowerCase());
            final matchesCompanyName =
                name == null ||
                (job.companyName.toLowerCase().contains(name.toLowerCase()));
            final matchesFirstType =
                name == null ||
                (job.firstType.toLowerCase().contains(name.toLowerCase()));
            final matchesSecondType =
                name == null ||
                (job.secondType.toLowerCase().contains(name.toLowerCase()));
            return matchesName ||
                matchesCompanyName ||
                matchesFirstType ||
                matchesSecondType;
          }).toList();

      emit(HomeSuccess(_allJobs, filtered));
    }
  }

  void resetSearch() {
    if (state is HomeSuccess) {
      emit(HomeSuccess(_allJobs));
    }
  }

  void filterByJobTitles(List<String> selectedJobs) {
    if (state is HomeSuccess) {
      final selectedTitles=selectedJobs.map((job)=>job).toSet();
      final filtered=_allJobs.where((job){
        return selectedTitles.contains(job.jobTitle);
      }).toList();
      emit(HomeSuccess(_allJobs,filtered));
    }
  }
}
