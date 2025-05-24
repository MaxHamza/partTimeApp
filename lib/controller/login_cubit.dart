import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // لتحويل البيانات
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String userName, String password) async {
    emit(LoginLoading());
    final baseUrl='http://192.168.1.17:7882/part-time-app/public/api/';
    final url = Uri.parse('${baseUrl}login'); // رابط الـ API
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_name': userName,
          'password': password,
        }),
      );
     String message;
      if (response.statusCode == 200||response.statusCode==201) {
        final data = jsonDecode(response.body);
        final token = data['token']; // مثال
        print('Login successful. Token: $token');
        emit(LoginSuccess());
      } else {
        message='Login failed. Status code: ${response.statusCode}';
        print('Login failed. Status code: ${response.statusCode}');
        print('Body: ${response.body}');
        emit(LoginFailure(message));
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(LoginFailure(e.toString()));
    }
  }

}
