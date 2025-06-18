import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parttime/core/utils/add_file_image.dart';
import 'package:parttime/main.dart';
import 'package:parttime/widgets/screen_background.dart';
class MyCv extends StatelessWidget {
  const MyCv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(),
          Center(child: Text('Please Put Your Cv',style: TextStyle(color: Colors.white,
            fontSize: 18,
          ),),),
          Positioned(
            top: 370.h,
            left: (width! / 2) - 100.w,
            width: 200.w,
            height: 50.h,
            child: ElevatedButton(
              onPressed: (){
                 pickCv();
              },
              child: Text('Click here',style: TextStyle(
                color: Colors.white
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
