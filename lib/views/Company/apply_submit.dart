import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/apply_job_cubit.dart';
import 'package:parttime/controller/authintication/login_cubit.dart';
import 'package:parttime/controller/user_inf_cubit.dart';
import 'package:parttime/core/utils/app_fonts.dart';
import 'package:parttime/main.dart';
import 'package:parttime/views/Company/company_view.dart';
import 'package:parttime/views/Home/home.dart';
import 'package:parttime/widgets/screen_background.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../controller/update_user_inf_cubit.dart';
import '../../core/utils/add_file_image.dart';
import '../../model/jobs.dart';

class Submit extends StatefulWidget {
  const Submit({super.key, required this.job});

  final Jobs job;

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  @override
  void initState() {
    BlocProvider.of<UserInfCubit>(context).getUserInformation();
    super.initState();
  }

  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.offAll(() => CompanyView(jobs: widget.job));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.lerp(
            Color(0xff6D00BB),
            Color(0xff320055),
            0.5,
          ),
          toolbarHeight: height! * 0.18,
          title: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              widget.job.jobTitle!,
              style: TextStyle(fontSize: 22.sp, color: Colors.white),
            ),
            subtitle: Text(
              widget.job.companyName!,
              style: TextStyle(fontSize: 18.sp, color: Colors.white),
            ),
          ),
        ),
        body: BlocBuilder<UserInfCubit, UserInfState>(
          builder: (context, state) {
            if (state is UserInfSuccess) {
              return Container(
                width: double.infinity,
                height: MediaQuery
                    .sizeOf(context)
                    .height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Row(
                        spacing: 9.w,
                        children: [
                          Container(
                            width: 54.w,
                            height: 54.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                state.user.image != null
                                    ? NetworkImage(state.user.image!)
                                    : AssetImage(
                                  "assets/images/person.png",
                                ),
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              Text(
                                state.user.user_name!,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontFamily: AppFonts.calibriBold,
                                ),
                              ),
                              Text(
                                state.user.job_title!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 18.w,
                        right: 18.w,
                        top: 25.h,
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: width,
                        height: 44.h,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: Color.fromARGB(163, 172, 171, 186),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10.w,
                          children: [
                            Image.asset("assets/images/file.png"),
                            Text(
                              state.user.cv != null
                                  ? "${state.user.user_name}_cv.${state.user.cv!
                                  .split('.').last}"
                                  : "cv_user_resume_cv.pdf",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 18.w,
                        right: 18.w,
                        top: 25.h,
                        bottom: 100.h,
                      ),
                      child: DottedBorder(
                        color: const Color.fromARGB(237, 255, 255, 255),
                        // Border color
                        strokeWidth: 1,
                        // Border thickness
                        dashPattern: [7, 7],
                        // Adjust the dash size
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10.r),

                        // Border radius
                        child: GestureDetector(
                          onTap: () async {
                            final path = await pickCv();
                            if (path != null) {
                              selectedFile = path;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('you have uploaded a New Cv'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Color.fromARGB(163, 172, 171, 186),
                            ),
                            child: Column(
                              spacing: 5.h,
                              children: [
                                Text(
                                  "Upload resume",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Text(
                                  "PDF, DOC, DOCX",
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      134,
                                      255,
                                      255,
                                      255,
                                    ),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocConsumer<ApplyJobCubit, ApplyJobState>(
                      listener: (context, state1) {
                        if (state1 is ApplyJobFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state1.message),
                              backgroundColor: Colors.red,),
                          );
                        } else if (state1 is ApplyJobSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Successful Applying"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Get.offAll(() => HomeView());
                        }
                      },
                      builder: (context, state1) {
                        bool isLoading = state1 is ApplyJobLoading;
                        if (state1 is ApplyJobLoading) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                left: width! * 0.06,
                                right: width! * 0.06,
                              ),
                              width: width! * 0.8,
                              height: 42.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color:
                                (state.user.cv != null && !isLoading &&
                                    selectedFile != null)
                                    ? Colors.grey
                                    : Color.fromARGB(163, 172, 171, 186),
                              ),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () async {
                            if (selectedFile != null) {
                              BlocProvider.of<ApplyJobCubit>(
                                context,
                              ).sendApplication(
                                jobOpportunityId: widget.job.id,
                                cv: selectedFile,
                              );
                            }

                            else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(
                                    'Please upload a CV before submitting')),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                              left: width! * 0.06,
                              right: width! * 0.06,
                            ),
                            width: width! * 0.8,
                            height: 42.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color:
                              (selectedFile != null && !isLoading)
                                  ? Colors.grey
                                  : Color.fromARGB(163, 172, 171, 186),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is UserInfLoading) {
              return Stack(
                children: [
                  ScreenBackground(),
                  Center(child: Text('You have an error in network')),
                ],
              );
            } else {
              return Stack(
                children: [
                  ScreenBackground(),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
          },
        ),
      ),
    );
  }


}
