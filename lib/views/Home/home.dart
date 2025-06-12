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

                  GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (controller) {
                      return CustomSearchBar(
                        controller: controller.search,
                        onTap: () {
                          controller.openFilterDialog(context);
                        },
                      );
                    },
                  ),
                  Positioned(
                    top: height! * 0.25,
                    right: 20.w,
                    left: 20.w,
                    child: SizedBox(
                      height: height! - (height! * 0.25),
                      child: ListView.builder(
                        itemCount: state.opportunities.length,
                        itemBuilder: (context, index) {
                          Jobs jobs = state.opportunities[index];
                          return CompanyCard(
                            onTap: () {
                              Get.offAll(() => CompanyView(jobs: jobs,));
                            },
                            title: jobs.jobTitle,
                            subtitle: jobs.companyName,
                            time: jobs.firstType,
                            place: jobs.secondType,
                            price: jobs.salaryRange,
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
