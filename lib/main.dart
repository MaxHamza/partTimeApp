import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/login_cubit.dart';
import 'package:parttime/home_binding.dart';
import 'package:parttime/views/Auth/login.dart';

void main(List<String> args) {
  ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

double? width;
double? height;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocProvider(
  create: (context) => LoginCubit(),
  child: GetMaterialApp(
          initialBinding: HomeBinding(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Calibri'),
          home: Login(),
        ),
);
      },
    );
  }
}
