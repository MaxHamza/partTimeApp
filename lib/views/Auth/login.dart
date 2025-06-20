import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/authintication/login_cubit.dart';
import 'package:parttime/views/Auth/signup.dart';
import 'package:parttime/views/Auth/widgets/custom_button.dart';
import 'package:parttime/views/Auth/widgets/custom_checkbox.dart';
import 'package:parttime/views/Auth/widgets/custom_login_header.dart';
import 'package:parttime/views/Auth/widgets/custom_textfield.dart';
import 'package:parttime/views/Home/home.dart';

import '../../controller/authintication/signup_cubit.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CustomLoginHeader(),
            SizedBox(height: 56.h),
            Form(
              child: Column(
                children: [
                  CustomTextfield(hint: "User name", controller: userName),
                  SizedBox(height: 30.h),
                  CustomTextfield(hint: "Password", controller: password),
                  CustomCheckbox(value: false),

                  // BlocConsumer بدل BlocBuilder
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              state.message,
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      else if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'You are signing in successfully!',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Get.offAll(() => HomeView());
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return CustomButton(
                        text: "Sign in",
                        onTap: () {
                          context.read<LoginCubit>().login(
                            userName.text,
                            password.text,
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.09),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(
                        () => BlocProvider(
                          create: (context) => SignupCubit(),
                          child: Signup(),
                        ),
                      );
                    },
                    child: Text(
                      "Don't have an account? Signup!",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
