import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/main.dart';
import 'package:parttime/views/Company/apply_submit.dart';
import 'package:parttime/views/Company/widgets/apply_button.dart';
import 'package:parttime/views/Company/widgets/comapny_job_describ.dart';
import 'package:parttime/views/Company/widgets/comapny_options.dart';
import 'package:parttime/views/Company/widgets/comapy_job_keys.dart';
import 'package:parttime/views/Company/widgets/company_appbar.dart';
import 'package:parttime/views/Company/widgets/company_jobtitle.dart';
import 'package:parttime/views/Company/widgets/company_location.dart';
import 'package:parttime/views/Company/widgets/company_name.dart';
import 'package:parttime/views/Home/home.dart';
import 'package:parttime/widgets/screen_background.dart';

import '../../model/jobs.dart';

class CompanyView extends StatelessWidget {
  const CompanyView({super.key,required this.jobs});
 final Jobs jobs;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Get.to(() => HomeView());
      },
      child: Scaffold(
        body: Stack(
          children: [
            ScreenBackground(),
            Positioned(
              top: height! * 0.01,
              left: width! * 0.02,
              right: width! * 0.02,
              child: SizedBox(
                height: height!,
                child: ListView(
                  children: [
                    CompanyAppbar(),
                    companyDetails(),
                    ApplyButton(
                      onTap: () {
                        debugPrint("Apply Button");
                        Get.offAll(() => Submit(job: jobs,));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container companyDetails() {
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Color.fromARGB(56, 172, 171, 186),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CompanyJobtitle(jobtitle: jobs.jobTitle!),
          CompanyName(comName: jobs.companyName!),
          CompanyLocation(comlocation:jobs.companyAddress!),
          ComapnyOptions(
            type: jobs.firstType!,
            time:jobs.secondType!,
            salary: jobs.salaryRange!,
          ),
          ComapnyJobDescrib(
            text: jobs.jobDescription!,
          ),
          CompanyJobKeys(
            keys: jobs.keyResponsibilities!
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.only(left: 23.w, bottom: 10.h),
            child: Text(
              "${jobs.companyAddress}: \n${jobs.firstType} Speak with the employer ${jobs.employerPhone}",
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }
}
