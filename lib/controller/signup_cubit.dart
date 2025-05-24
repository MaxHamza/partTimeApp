import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void signUp(String userName,String identifier,String password,String country,String jobTitle)async {
    emit(SignupLoading());
    final url = Uri.parse(
      'http://192.168.1.17:7882/part-time-app/public/api/signup',
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_name': userName,
          'identifier': identifier,
          'password':password,
          'country':country,
          'job_title':jobTitle,
        }),
      );
      if(response.statusCode==200||response.statusCode==201){
       print('sign up successfully');
       emit(SignupSuccess());
      }
      else{
        String message;
        message='Sign up failed. Status code: ${response.statusCode}';
        print('Sign up failed. Status code: ${response.statusCode}');
        print('Body: ${response.body}');
        emit(SignupFailure(message));
      }
    } catch (e) {
      print(e.toString());
      emit(SignupFailure(e.toString()));
    }
  }
}
