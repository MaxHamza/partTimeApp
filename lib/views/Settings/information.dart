import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parttime/controller/profile/update_user_inf_cubit.dart';
import 'package:parttime/controller/profile/user_inf_cubit.dart';
import 'package:parttime/main.dart';
import 'package:parttime/views/Settings/widgets/custom_info_field.dart';
import 'package:parttime/views/Settings/widgets/custom_save_button.dart';
import 'package:parttime/views/Settings/widgets/sign_in_inf.dart';
import 'package:parttime/widgets/screen_background.dart';

import '../../core/utils/add_file_image.dart';
import '../../model/user.dart';

class Information extends StatelessWidget {
   Information({super.key,  this.image});
   String ?image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserInfCubit,UserInfState>(
        builder: (context,state) {
          if (state is UserInfSuccess) {
            return Stack(
              children: [
                ScreenBackground(),
                Container(
                  width: width,
                  height: 190.h,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(150, 82, 0, 141)),
                ),
                Positioned(
                  top: 150.h,
                  left: (width! / 2) - 40.w,
                  child: SizedBox(
                    width: 80.w,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: GestureDetector(
                        onTap: () async {
                          final path = await pickImageFile();
                          BlocProvider.of<UpdateUserInfCubit>(context)
                              .updateUserInf(image: File(path!));
                          BlocProvider.of<UserInfCubit>(context)
                              .getUserInformation();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: state.user.image != null
                                  ? NetworkImage(state.user.image!)
                                  : AssetImage("assets/images/person.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(75.r),
                            border: Border.all(
                                color: Color(0xffF39C12), width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
               SignInInf(user: state.user,)
              ],
            );
          }
          else if(state is UserInfFailure){
           return Center(child: Text(state.message),);
          }
          else{
            return Stack(
              children: [
                ScreenBackground(),
                Container(
                  width: width,
                  height: 190.h,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(150, 82, 0, 141)),
                ),
                Positioned(
                  top: 150.h,
                  left: (width! / 2) - 40.w,
                  child: SizedBox(
                    width: 80.w,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: GestureDetector(
                        onTap: () async {
                          final path = await pickImageFile();
                          BlocProvider.of<UpdateUserInfCubit>(context)
                              .updateUserInf(image: File(path!));
                          BlocProvider.of<UserInfCubit>(context)
                              .getUserInformation();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image != null
                                  ? NetworkImage(image!)
                                  : AssetImage("assets/images/person.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(75.r),
                            border: Border.all(
                                color: Color(0xffF39C12), width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
             SignInInf(),
              ],
            );
          }
        }
      ),
    );
  }
}
