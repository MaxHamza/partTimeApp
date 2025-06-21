import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/controller/applications/apply_job_cubit.dart';
import 'package:parttime/model/application_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'get_applications_state.dart';

class GetApplicationsCubit extends Cubit<GetApplicationsState> {
  final SharedPreferences prefs;

  GetApplicationsCubit(this.prefs) : super(GetApplicationsInitial());


  List<ApplicationModel> _apps = [];

  Future<void> fetchRequests() async {
    emit(GetApplicationsLoading());
    try {
      final token = prefs.getString('token') ?? '';
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.17:7882/part-time-app/public/api/applications'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print('Response: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> responseData = jsonResponse['data'];

        print('ResponseData: $responseData');
        print(
            'Response key_responsibilities: ${responseData[0]['job_opportunity']['key_responsibilities']}');

        if (responseData != null && responseData.isNotEmpty) {
          final requests = responseData
              .where((e) => e is Map<String, dynamic>)
              .map((e) => ApplicationModel.json(e as Map<String, dynamic>))
              .toList();
          _apps = requests;
          emit(GetApplicationsSuccess(_apps));
        } else {
          emit(GetApplicationsFailure('No applications found'));
        }
      } else {
        emit(GetApplicationsFailure('Failed to load data'));
      }
    } catch (e) {
      emit(GetApplicationsFailure('Error: $e'));
    }
  }
}
