import 'dart:convert';
import 'dart:io';

import 'package:parttime/model/jobs.dart';

class ApplicationModel {


  final int ?id;
  final int ?userId;
  final Jobs ?jobOppurtunity;
  final double? salary;
  final String? cv;
  final bool? status;
  final String ?appTime;

  ApplicationModel({
     this.id,
     this.cv,
     this.userId,
     this.appTime,
    this.jobOppurtunity,
     this.salary,
     this.status,
  });
  factory ApplicationModel.json(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      userId: json['user_id'] != null ? int.tryParse(json['user_id'].toString()) : null,
      appTime: json['application_time'],
      cv: json['cv'],
      salary: json['salary'] != null ? (json['salary'] as num).toDouble() : null,
      status: json['status'] != null
          ? (json['status'] is bool
          ? json['status']
          : json['status'].toString() == '1')
          : null,
      jobOppurtunity: json['job_opportunity'] != null
          ? Jobs.fromJson(json['job_opportunity'] as Map<String, dynamic>)
          : null,
    );
  }



}
