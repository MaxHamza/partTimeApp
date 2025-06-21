import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parttime/controller/profile/update_user_inf_cubit.dart';
import 'package:parttime/controller/profile/user_inf_cubit.dart';
import 'package:parttime/core/utils/add_file_image.dart';
import 'package:parttime/main.dart';
import 'package:parttime/widgets/screen_background.dart';

class MyCv extends StatelessWidget{
const  MyCv({super.key,  this.cv});
final String? cv;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserInfCubit, UserInfState>(
  builder: (context, state) {
    if(state is UserInfLoading){
      return Stack(
        children: [
          ScreenBackground(),
          Center(child: CircularProgressIndicator(),),
        ],
      );
    }
    else if(state is UserInfSuccess){
      return Stack(
        children: [
          ScreenBackground(),
          Positioned(
            top: 330.h,
            left: (width! / 2) - 70.w,
            child: Text('Please Put Your Cv',style: TextStyle(color: Colors.white,
              fontSize: 18,
            ),),
          ),
          Positioned(
            top: 370.h,
            left: (width! / 2) - 100.w,
            width: 200.w,
            height: 50.h,
            child: ElevatedButton(
              onPressed: ()async{
                final  path=await pickCv();
                if(path!=null) {
                  await BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      cv: path);
                  BlocProvider.of<UserInfCubit>(context).getUserInformation();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(163, 172, 171, 186),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Click here',style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
              ),),
            ),
          ),
          state.user.cv!=null?    Positioned(
            top: 500.h,
            left: (width! / 2) - 150.w,
            width: 300.w,
            height: 50.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Color.fromARGB(163, 172, 171, 186).withOpacity(0.9),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
                border: Border.all(color: Colors.blueGrey, width: 1),
              ),
              child: Text(Uri.parse(state.user.cv!).pathSegments.last,style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ):Container(),
        ],
      );
    }
    return Stack(
        children: [
          ScreenBackground(),
          Positioned(
            top: 330.h,
            left: (width! / 2) - 70.w,
            child: Text('Please Put Your Cv',style: TextStyle(color: Colors.white,
              fontSize: 18,
            ),),
          ),
          Positioned(
            top: 370.h,
            left: (width! / 2) - 100.w,
            width: 200.w,
            height: 50.h,
            child: ElevatedButton(
              onPressed: ()async{
                final path=await pickCv();
                if(path!=null) {
                 await BlocProvider.of<UpdateUserInfCubit>(context).updateUserInf(
                      cv: File(path.path!));
                 BlocProvider.of<UserInfCubit>(context).getUserInformation();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(115, 187, 187, 187),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Click here',style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),),
            ),
          ),
      cv!=null?    Positioned(
            top: 500.h,
            left: (width! / 2) - 100.w,
            width: 200.w,
            height: 50.h,
            child: Container(
              child: Text(Uri.parse(cv!).pathSegments.last,style: TextStyle(
                color: Colors.white
              ),),
            ),
          ):Container(),
        ],
      );
  },
),
    );
  }

}
