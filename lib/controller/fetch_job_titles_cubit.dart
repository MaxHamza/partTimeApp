import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:parttime/model/jobs.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'fetch_job_titles_state.dart';

class FetchJobTitlesCubit extends Cubit<FetchJobTitlesState> {
  final SharedPreferences prefs;
  FetchJobTitlesCubit(this.prefs) : super(FetchJobTitlesInitial());
  Future<void>fetchJobTitles() async{
    final baseUrl = 'http://192.168.1.17:7882/part-time-app/public/api/jobTitles';
    final url=Uri.parse(baseUrl);
    try {
      final response = await http.get(url,
        headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
          'Content-Type': 'application/json',
        },
      );
      if(response.statusCode==200||response.statusCode==201){
        final responseData = json.decode(response.body)['data'];
        final List<String> jobTitles = List<String>.from(responseData);
        print(jobTitles);
        emit(FetchJobTitlesSuccess(jobTitles));
      }
      else{
        emit(FetchJobTitlesFailure('Failed to load data: ${response.statusCode}'));
      }
    }
    catch (e) {
      print('Error occurred: $e');
      emit(FetchJobTitlesFailure(e.toString()));
    }
  }
}
