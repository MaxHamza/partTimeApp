import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parttime/controller/authintication/logout_cubit.dart';
import 'package:parttime/controller/fetch_job_titles_cubit.dart';
import 'package:parttime/controller/home_controller.dart';
import 'package:parttime/controller/home_cubit.dart';
import 'package:parttime/main.dart';
import 'package:parttime/model/jobs.dart';
import 'package:parttime/views/Company/company_view.dart';
import 'package:parttime/views/Home/widgets/company_card.dart';
import 'package:parttime/views/Home/widgets/custom_search_bar.dart';
import 'package:parttime/views/Settings/profile.dart';
import 'package:parttime/widgets/screen_background.dart';
import '../../controller/authintication/login_cubit.dart';
import '../../core/utils/app_color.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final homeController = Get.find<HomeController>();
  final TextEditingController searchCon = TextEditingController();
  List<String>? selectedUserList = [];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchJobTitlesCubit>(
            create: (context) => FetchJobTitlesCubit(BlocProvider.of<LoginCubit>(context).prefs)..fetchJobTitles()),
        BlocProvider<HomeCubit>(create: (context)=> HomeCubit(BlocProvider.of<LogoutCubit>(context).prefs)..fetchJobOpportunities(),),
      ],
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
              return Center(child: Text(state.message));
            } else if (state is HomeSuccess) {
              List<Jobs> allJobs=[] ;
                  if(selectedUserList!.isNotEmpty){
                    allJobs=state.filteredJobs.where((job){
                      return selectedUserList!.contains(job.jobTitle);
                    }).toList();}
                    else{
                      allJobs=state.filteredJobs;
                  }

              return Stack(
                children: [
                  ScreenBackground(),
                  // العنوان
                  Positioned(
                    top: height! * 0.08,
                    left: width! * 0.4,
                    child: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 28.sp),
                    ),
                  ),

                  // شريط البحث
                  Positioned(
                    top: height! * 0.15,
                    left: 20.w,
                    right: 20.w,
                    child: BlocBuilder<FetchJobTitlesCubit, FetchJobTitlesState>(
                          builder: (context, state1) {
                            if(state1 is FetchJobTitlesSuccess) {
                              return CustomSearchBar(
                                onTap: () async {
                                  await FilterListDialog.display(
                                    height: height!,
                                    width: width,
                                    insetPadding: EdgeInsets.only(
                                      top: height! * 0.25,
                                    ),
                                    hideHeader: true,
                                    backgroundColor: const Color.fromARGB(
                                      115, 78, 78, 78,
                                    ),
                                    themeData: FilterListThemeData(
                                      choiceChipTheme: ChoiceChipThemeData(
                                        backgroundColor: AppColor.offWhite,
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      context,
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        78,
                                        78,
                                        78,
                                      ),
                                    ),
                                    hideSearchField: true,
                                    context,
                                    listData: state1.jobTitles,
                                    selectedListData: selectedUserList,
                                    choiceChipLabel: (user) => user!,
                                    validateSelectedItem:
                                        (list, val) => list!.contains(val),
                                    onItemSearch: (user, query) {
                                      return user.toLowerCase()
                                          .contains(
                                        query.toLowerCase(),
                                      );
                                    },
                                    onApplyButtonClick: (list) {
                                      selectedUserList = List.from(list!);
                                     context.read<HomeCubit>().filterByJobTitles(selectedUserList!);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                controller: searchCon,
                                onChanged: (val) {
                                  context.read<HomeCubit>().searchJobs(
                                      name: val);
                                },
                              );
                            }
                            else if(state1 is FetchJobTitlesFailure){
                           return Center(child:Text(state1.message));
                            }
                            else{
                              return   Container();
                            }
                          },
                        ),
                  ),

                  // قائمة الوظائف
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
                              Get.offAll(
                                () => CompanyView(jobs: allJobs[index]),
                              );
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
            } else {
              return Stack(children:[
                ScreenBackground(),
                Center(child: CircularProgressIndicator())]);
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
