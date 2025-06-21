import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/profile/update_user_inf_cubit.dart';
import '../../../controller/profile/user_inf_cubit.dart';
import '../../../main.dart';
import '../../../model/user.dart';
import '../profile.dart';
import 'custom_info_field.dart';
import 'custom_save_button.dart';

class SignInInf extends StatefulWidget {
  SignInInf({super.key, this.user});
  User? user;
  @override
  State<SignInInf> createState() => _SignInInfState();
}

class _SignInInfState extends State<SignInInf> {
  final userNameCon = TextEditingController();
  final emailPhoneCon = TextEditingController();
  final countryCon = TextEditingController();
  final passCon = TextEditingController();
  final jobTitleCon = TextEditingController();

  @override
  void dispose() {
    userNameCon.dispose();
    emailPhoneCon.dispose();
    countryCon.dispose();
    passCon.dispose();
    jobTitleCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height! / 2.7,
      child: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            spacing: 25.h,
            children: [
              CustomInfoField(hint: "User name", controller: userNameCon),
              CustomInfoField(
                hint: "Email or Phone number",
                controller: emailPhoneCon,
              ),
              CustomInfoField(hint: "Country", controller: countryCon),
              CustomInfoField(hint: "Password", controller: passCon),
              CustomInfoField(hint: "Jobtitle", controller: jobTitleCon),
              CustomSaveButton(
                title: "Save",
                onTap: () async{
                  if (userNameCon.text.isNotEmpty) {
                    await   BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      userName:
                          userNameCon.text.isNotEmpty
                              ? userNameCon.text
                              : widget.user!.user_name ?? '',
                    );
                  }
                  if (emailPhoneCon.text.isNotEmpty) {
                    await   BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      identifier:
                          emailPhoneCon.text.isNotEmpty
                              ? emailPhoneCon.text
                              : widget.user!.email?? '',
                    );
                  }
                  if (countryCon.text.isNotEmpty) {
                    await   BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      country:
                          countryCon.text.isNotEmpty
                              ? countryCon.text
                              : widget.user!.country ?? '',
                    );
                  }
                  if (passCon.text.isNotEmpty) {
                    await BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      password:
                          passCon.text.isNotEmpty
                              ? passCon.text
                              : widget.user!.password ?? '',
                    );
                  }
                  if (jobTitleCon.text.isNotEmpty){
                  await  BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      jobTitle: jobTitleCon.text.isNotEmpty
                              ? jobTitleCon.text
                              : widget.user!.job_title ?? '',
                    );
                  }
                  BlocProvider.of<UserInfCubit>(context).getUserInformation();
                  Get.offAll(()=>Profile());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}