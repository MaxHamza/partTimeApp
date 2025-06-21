import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parttime/model/application_model.dart';

import '../../../main.dart';
import '../../Company/widgets/comapny_job_describ.dart';
import '../../Company/widgets/comapny_options.dart';
import '../../Company/widgets/comapy_job_keys.dart';
import '../../Company/widgets/company_jobtitle.dart';
import '../../Company/widgets/company_location.dart';
import '../../Company/widgets/company_name.dart';
class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key, required this.app});
  final ApplicationModel app;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900.withOpacity(0.4),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              companyDetails(),
              SizedBox(height: 10,),
              Text("Requist Time: ${app.appTime!}",style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
              Text("status: ${app.status}",style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
              Text("salary: ${app.salary??0.0.toString()}",style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
            ],
          ),
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
          CompanyJobtitle(jobtitle: app.jobOppurtunity!.jobTitle!),
          CompanyName(comName: app.jobOppurtunity!.companyName!),
          CompanyLocation(comlocation:app.jobOppurtunity!.companyAddress!),
          ComapnyOptions(
            type: app.jobOppurtunity!.firstType!,
            time:app.jobOppurtunity!.secondType!,
            salary: app.jobOppurtunity!.salaryRange??'200',
          ),
          // ComapnyJobDescrib(
          //   text: app.jobOppurtunity!.jobDescription!,
          // ),
          CompanyJobKeys(
              keys: app.jobOppurtunity!.keyResponsibilities!
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.only(left: 23.w, bottom: 10.h),
            child: Text(
              "${app.jobOppurtunity!.companyAddress}: \n${app.jobOppurtunity!.firstType} Speak with the employer ${app.jobOppurtunity!.employerPhone}",
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }
}
