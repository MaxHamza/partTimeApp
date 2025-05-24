import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/signup_cubit.dart';
import 'package:parttime/controller/signup_cubit.dart';
import 'package:parttime/views/Auth/login.dart';
import 'package:parttime/views/Auth/widgets/custom_button.dart';
import 'package:parttime/views/Auth/widgets/custom_textfield.dart';
import 'package:parttime/views/Home/home.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  @override
  TextEditingController userName = TextEditingController();
  TextEditingController emailPhone = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.offAll(() => Login());
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.only(
              right: MediaQuery.sizeOf(context).width * 0.05,
              left: MediaQuery.sizeOf(context).width * 0.05,
              top: MediaQuery.sizeOf(context).height * 0.117,
            ),
            children: [
              Text(
                "Let's create your account in Job Finder!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "CalibriBold",
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                "Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32.sp, color: Colors.white),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Form(
                  child: Column(
                    spacing: 30.h,
                    children: [
                      CustomTextfield(hint: "User name", controller: userName),
                      CustomTextfield(
                        hint: "Email or phone number",
                        controller: emailPhone,
                      ),
                      CustomTextfield(hint: "Country", controller: country),
                      CustomTextfield(hint: "Password", controller: password),
                      CustomTextfield(hint: "Job title", controller: jobTitle),
                      BlocConsumer<SignupCubit, SignupState>(
                        listener: (context, state) {
                          if (state is SignupSuccess) {
                            Get.offAll(Login());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Sign up Successfully',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is SignupFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                  state.message,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SignupLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return CustomButton(
                            text: "Sign up",
                            onTap: () {
                              BlocProvider.of<SignupCubit>(context).signUp(
                                userName.text,
                                emailPhone.text,
                                password.text,
                                country.text,
                                jobTitle.text,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
