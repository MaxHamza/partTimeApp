import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/authintication/logout_cubit.dart';
import 'package:parttime/controller/update_user_inf_cubit.dart';
import 'package:parttime/controller/user_inf_cubit.dart';
import 'package:parttime/core/utils/app_fonts.dart';
import 'package:parttime/views/Home/verify_login.dart';
import 'package:parttime/views/Settings/information.dart';
import 'package:parttime/views/Settings/widgets/profile_option.dart';
import 'package:parttime/widgets/screen_background.dart';

import '../../core/utils/add_file_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? pickedImagePath;
  @override
  void initState() {
    BlocProvider.of<UserInfCubit>(context).getUserInformation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) {
            if (state is LogoutFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is LogoutSuccess) {
              //استبدل Get.offAll بمهمة microtask لتجنب إعادة بناء لا نهائية
              Get.back();
              Future.microtask(() => Get.offAll(() => VerifyLogin()));
            }
          }, // بناء الواجهة العامة
          child: BlocBuilder<UserInfCubit, UserInfState>(
  builder: (context, state) {
    if(state is UserInfFailure) {
      return Stack(
        children: [
          ScreenBackground(),
          Container(
            width: width,
            height: 190.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(150, 82, 0, 141),
            ),
          ),
          Positioned(
            top: 150.h,
            left: (width / 2) - 40.w,
            child: SizedBox(
              width: 80.w,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/person.png"),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.circular(75.r),
                      border: Border.all(
                        color: const Color(0xffF39C12),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 230.h,
            left: (width / 2) - 33.w,
            child: Text(
              "User name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: AppFonts.calibriBold,
              ),
            ),
          ),
          Positioned(
            top: 250.h,
            left: width * 0.39,
            child: Text(
              "UI/UX Designer",
              style: TextStyle(
                color: const Color.fromARGB(158, 255, 255, 255),
                fontSize: 14.sp,
                fontFamily: AppFonts.calibri,
              ),
            ),
          ),
          Positioned(
            top: height * 0.45,
            right: width * 0.02,
            left: width * 0.02,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileOption(
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.white,
                  ),
                  title: "My Cv",
                ),
                SizedBox(height: 16.h),
                ProfileOption(
                  onTap: () {
                    Get.offAll(() => Information());
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  title: "Sign in",
                ),
                SizedBox(height: 16.h),
                ProfileOption(
                  icon: const Icon(
                    Icons.request_page_outlined,
                    color: Colors.white,
                  ),
                  title: "Requests",
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.9,
            right: width * 0.04,
            left: width * 0.04,
            child: InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure you need to logout'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<LogoutCubit>(context).logout();
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.logout, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      );
    }
    else if(state is UserInfSuccess){
  return    Stack(
        children: [
          ScreenBackground(),
          Container(
            width: width,
            height: 190.h,
            decoration: const BoxDecoration(
              color: Color.fromARGB(150, 82, 0, 141),
            ),
          ),
          Positioned(
            top: 150.h,
            left: (width / 2) - 40.w,
            child: SizedBox(
              width: 80.w,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: InkWell(
                  onTap: ()async{
                    final path = await pickImageFile();
                    if (path != null) {
                      setState(() {
                        pickedImagePath = path;
                      });
                      BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                          image: File(path));

                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image:  DecorationImage(
                        image:state.user.image!=null ? NetworkImage(state.user.image!):
                        AssetImage("assets/images/person.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(75.r),
                      border: Border.all(
                        color: const Color(0xffF39C12),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 230.h,
            left: (width / 2) - 40.w,
            child: Text(
              state.user.user_name??'user_name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontFamily: AppFonts.calibriBold,
              ),
            ),
          ),
          Positioned(
            top: 250.h,
            left: width * 0.39,
            child: Text(
             state.user.job_title?? 'job title',
              style: TextStyle(
                color: const Color.fromARGB(158, 255, 255, 255),
                fontSize: 14.sp,
                fontFamily: AppFonts.calibri,
              ),
            ),
          ),
          Positioned(
            top: height * 0.45,
            right: width * 0.02,
            left: width * 0.02,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileOption(
                  icon: const Icon(
                    Icons.edit_document,
                    color: Colors.white,
                  ),
                  title: "My Cv",
                ),
                SizedBox(height: 16.h),
                ProfileOption(
                  onTap: () {
                    Get.offAll(() => Information());
                  },
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  title: "Sign in",
                ),
                SizedBox(height: 16.h),
                ProfileOption(
                  icon: const Icon(
                    Icons.request_page_outlined,
                    color: Colors.white,
                  ),
                  title: "Requests",
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.9,
            right: width * 0.04,
            left: width * 0.04,
            child: InkWell(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure you need to logout'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<LogoutCubit>(context).logout();
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.logout, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      );
    }
    else{
    return Center(child: CircularProgressIndicator());
    }
  },
),
        ),
      ),
    );
  }
}
