import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/jobs.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final SharedPreferences prefs;
  HomeCubit(this.prefs) : super(HomeInitial());
  Future<void> fetchJobOpportunities() async {
    emit(HomeLoading());
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.17:7882/part-time-app/public/api/jobOpportunities'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];
        final opportunities = data
            .map((json) => Jobs.fromJson(json))
            .toList();
        emit(HomeSuccess(opportunities));
      } else {
        emit(HomeFailure('Failed to load data: ${response.statusCode}'));
      }
    } catch (e) {
      emit(HomeFailure('Error: $e'));
    }
  }
}