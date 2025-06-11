import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/login_cubit.dart';
import 'package:parttime/controller/logout_cubit.dart';
import 'package:parttime/home_binding.dart';
import 'package:parttime/views/Auth/login.dart';
import 'package:parttime/views/Home/verify_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized(); // يجب أن يكون أول سطر
  await ScreenUtil.ensureScreenSize();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

double? width;
double? height;

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // الآن يمكن استخدام MediaQuery بأمان
        width = MediaQuery.sizeOf(context).width;
        height = MediaQuery.sizeOf(context).height;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginCubit(prefs)),
            BlocProvider(create: (context)=>LogoutCubit(prefs))
          ],
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
