import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parttime/main.dart';

class RequestCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String time;
  final bool status;
  final double salary;

  const RequestCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.time,
    required this.status,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 30.h,horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade900.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jobTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            companyName,
            style: TextStyle(
              color: Colors.indigo.shade100,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(Icons.access_time, time),
              _infoItem(Icons.request_page_outlined, status.toString()),
              _infoItem(Icons.attach_money, salary.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo.shade100, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.indigo.shade100,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
