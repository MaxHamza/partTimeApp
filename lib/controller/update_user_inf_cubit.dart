import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'update_user_inf_state.dart';

class UpdateUserInfCubit extends Cubit<UpdateUserInfState> {
  final SharedPreferences prefs;

  UpdateUserInfCubit(this.prefs,) : super(UpdateUserInfInitial());

  Future<void>updateUserInf({String? userName,
    String? identifier,
    String? country,
    String? jobTitle,
    String? password,
    File? cv,
    File? image,
  }
  )async{
    final url=Uri.parse('http://192.168.1.17:7882/part-time-app/public/api/user/update');
    try{
     final request= http.MultipartRequest('POST', url);
     request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
     request.headers['Accept'] = 'application/json';
     // request.headers['Accept']='application/json';
// لا تضف Content-Type أبداً هنا
     print(prefs.getString('token'));
      if(userName!=null)request.fields['user_name']=userName;
     if(identifier!=null)request.fields['identifier']=identifier;
     if(country!=null)request.fields['country']=country;
     if(jobTitle!=null)request.fields['job_title']=jobTitle;
     if(password!=null)request.fields['password']=password;
     if(cv!=null)request.files.add(await http.MultipartFile.fromPath('cv', cv.path));
     if (image != null) {
       request.files.add(await http.MultipartFile.fromPath('image', image.path));
     }
    final streamedResponse=await request.send();
    final response= await http.Response.fromStream(streamedResponse);
     if(response.statusCode==200||response.statusCode==201){
        final respons=json.decode(response.body);
        print('success ${respons}');
        if (!isClosed) emit(UpdateUserInfSuccess());

      }
    }
    catch(e){
      print(prefs.getString('token'));
      emit(UpdateUserInfFailure(e.toString()));
    }
  }
}
