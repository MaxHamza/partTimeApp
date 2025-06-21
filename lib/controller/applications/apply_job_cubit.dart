import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:parttime/model/application_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'apply_job_state.dart';
class ApplyJobCubit extends Cubit<ApplyJobState> {
  final SharedPreferences prefs;
  ApplyJobCubit(this.prefs) : super(ApplyJobInitial());

  Future<void> sendApplication({int? jobOpportunityId,  File? cv}) async {
    emit(ApplyJobLoading());
    final url = 'http://192.168.1.17:7882/part-time-app/public/api/applications';

    try {
      if (cv == null) {
        emit(ApplyJobFailure('CV file is required'));
        return;
      }

      final token = prefs.getString('token');
      if (token == null) {
        emit(ApplyJobFailure('Authorization token is missing'));
        return;
      }

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['job_opportunity_id'] = jobOpportunityId.toString();
      request.files.add(await http.MultipartFile.fromPath('cv', cv.path));
      request.headers['Authorization'] = 'Bearer $token';

      final stream = await request.send();
      final response = await http.Response.fromStream(stream);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        final decoded = jsonDecode(response.body);
        if (decoded['data'] != null) {
          final appModel = ApplicationModel.json(decoded['data']);
          print('decoded: :'+decoded);
          print(appModel);
          emit(ApplyJobSuccess(appModel));
        } else {
          emit(ApplyJobSuccess(null));
        }
      } else {
        print('error: ${response.statusCode} ${response.body}');
        emit(ApplyJobFailure('error: ${response.statusCode} ${response.body}'));
      }
    } catch (e) {
      print('error in Network: $e');
      emit(ApplyJobFailure('error in Network: $e'));
    }
  }
}


