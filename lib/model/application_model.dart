import 'dart:io';

import 'package:parttime/model/jobs.dart';

class ApplicationModel {
  // 'id' => $this->id,
  // 'user_id' => $this->user_id,
  // 'job_opportunity' => $this->jobOpportunity,
  // 'salary' => $this->salary,
  // 'cv' => $this->cv ? url('storage/'.$this->cv) : null,
  // 'status' => $this->status,
  // 'application_time' => $this->created_at,

  final int id;
  final int userId;
  final Jobs jobOppurtunity;
  final double salary;
  final String cv;
  final String status;
  final String appTime;

  ApplicationModel({
    required this.id,
    required this.cv,
    required this.userId,
    required this.appTime,
    required this.jobOppurtunity,
    required this.salary,
    required this.status,
  });

  factory ApplicationModel.json(Map<String, dynamic> json) {
    return ApplicationModel(
      id: json['id'],
      cv: json['cv'],
      userId: json['user_id'],
      appTime: json['application_time'],
      jobOppurtunity: json['job_opportunity'],
      salary: json['salary'],
      status: json['status'],
    );
  }
}
