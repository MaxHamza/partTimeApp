import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/controller/authintication/login_cubit.dart';
import 'package:parttime/controller/home_cubit.dart';
import 'package:parttime/views/Auth/login.dart';
import 'package:parttime/views/Home/home.dart';
class VerifyLogin extends StatelessWidget {
  const VerifyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    if(BlocProvider.of<LoginCubit>(context).prefs.getBool('logged')==true){
    return HomeView();}
    else{
      return Login();
    }
  }
}
