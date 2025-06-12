import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
part 'logout_state.dart';


class LogoutCubit extends Cubit<LogoutState> {
  final SharedPreferences prefs;
  LogoutCubit(this.prefs) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    final baseUrl='http://192.168.1.17:7882/part-time-app/public/api/';
    final url = Uri.parse('${baseUrl}logout'); // رابط الـ API
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      String message;
      print('Token: ${prefs.getString('token')}');
      if (response.statusCode == 200||response.statusCode==201) {
        prefs.remove('token');
        prefs.setBool('logged', false);
        emit(LogoutSuccess());
      } else {
        message='Logout failed ${response.statusCode}';
        print('Logout failed. Status code: ${response.statusCode}');
        emit(LogoutFailure(message));
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(LogoutFailure(e.toString()));
    }
  }
}

