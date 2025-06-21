import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/model/user.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'user_inf_state.dart';

class UserInfCubit extends Cubit<UserInfState> {
  final SharedPreferences prefs;
  UserInfCubit(this.prefs) : super(UserInfInitial());

  void getUserInformation()async{
    emit(UserInfLoading());
    final baseUrl='http://192.168.1.17:7882/part-time-app/public/api/user/show';
    final url=Uri.parse(baseUrl);
    try {
      final response = await http.get(url,
          headers: {
            'Authorization': 'Bearer ${prefs.getString('token')}',
            'Accept': 'application/json',
          }
      );
      if(response.statusCode==200||response.statusCode==201){
        final responseData=json.decode(response.body)['data'];
        print(responseData);
        final User user=User.fromJson(responseData);
        emit(UserInfSuccess(user));
      }
      else{
        emit(UserInfFailure('Failed to load data: ${response.statusCode}'));
      }
    }
    catch(e){
      emit(UserInfFailure(e.toString()));
    }
  }
}