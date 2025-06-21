import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parttime/controller/authintication/login_cubit.dart';
import 'package:parttime/controller/applications/get_applications_cubit.dart';
import 'package:parttime/model/application_model.dart';
import 'package:parttime/views/Settings/widgets/request_card.dart';
import 'package:parttime/views/Settings/widgets/request_details.dart';
import 'package:parttime/widgets/screen_background.dart';

class MyRequests extends StatelessWidget {
  const MyRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetApplicationsCubit, GetApplicationsState>(
        builder: (context, state) {
          if(state is GetApplicationsSuccess) {
            return Stack(
              children: [
                ScreenBackground(),
          state.applys!=null? Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      ApplicationModel app=state.applys![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Get.to(()=>RequestDetails(app: app,));
                          },
                          child: RequestCard(jobTitle: app.jobOppurtunity!.jobTitle!,
                              companyName: app.jobOppurtunity!.companyName!,
                              time: app.appTime!,
                              status: app.status??false,
                              salary: app.salary??0.0),
                        ),
                      );
                    },
                    itemCount: state.applys!.length),
                  ):Center(child: Text('You don\'t have any Request Yet',style: TextStyle(color: Colors.white,
          fontSize: 18,
          ),),),
              ],
            );
          }
          else if(state is GetApplicationsFailure){
            return Stack(
              children: [
              ScreenBackground(),
                Center(child: Text('You don\'t have any Request Yet',style: TextStyle(color: Colors.white, fontSize: 18,
                ),),),
              ],
            );
          }
          else{
          return Stack(
            children: [
             ScreenBackground(),
              Center(child: CircularProgressIndicator(),),
            ],
          )   ;
          }
        },
      ),
    );
  }
}
