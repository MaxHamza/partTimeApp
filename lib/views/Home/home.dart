import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/authintication/logout_cubit.dart';
import 'package:parttime/controller/home_controller.dart';
import 'package:parttime/controller/home_cubit.dart';
import 'package:parttime/controller/home_cubit.dart';
import 'package:parttime/main.dart';
import 'package:parttime/model/jobs.dart';
import 'package:parttime/views/Company/company_view.dart';
import 'package:parttime/views/Home/widgets/company_card.dart';
import 'package:parttime/views/Home/widgets/custom_search_bar.dart';
import 'package:parttime/views/Settings/profile.dart';
import 'package:parttime/widgets/screen_background.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final homeController = Get.find<HomeController>();
  TextEditingController searchCon=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeCubit(BlocProvider.of<LogoutCubit>(context).prefs)..fetchJobOpportunities(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(106, 255, 255, 255),
          onPressed: () {
            Get.offAll(() => Profile());
          },
          child: Icon(Icons.settings, color: Color(0xffffffff)),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeFailure) {
              return Center(child: Text(state.message),);
            }
            else if (state is HomeSuccess) {
              List<Jobs>allJobs=state.filteredJobs;
              return Stack(
                children: [
                  ScreenBackground(),
                  Positioned(
                    top: height! * 0.08,
                    left: width! * 0.4,
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 28.sp),
                    ),
                  ),
                  CustomSearchBar(
                    controller: searchCon,
                   onChanged: (val){
                     context.read<HomeCubit>().searchJobs(name: val);
                   },
                  ),
                  Positioned(
                    top: height! * 0.25,
                    right: 20.w,
                    left: 20.w,
                    child: SizedBox(
                      height: height! - (height! * 0.25),
                      child: ListView.builder(
                        itemCount: allJobs.length,
                        itemBuilder: (context, index) {
                          return CompanyCard(
                            onTap: () {
                              Get.offAll(() => CompanyView(jobs: allJobs[index],));
                            },
                            title: allJobs[index].jobTitle,
                            subtitle: allJobs[index].companyName,
                            time: allJobs[index].firstType,
                            place: allJobs[index].secondType,
                            price: allJobs[index].salaryRange,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}
//MVC
//MODEL - VIEW - CONTROLLER

//
