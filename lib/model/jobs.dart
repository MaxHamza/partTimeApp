import 'dart:convert';
class Jobs {
  final int? id;
  final String? jobTitle;
  final String? jobDescription;
  final String? firstType;
  final String? secondType;
  final String? salaryRange;
  final String? companyName;
  final String? companyAddress;
  final List<String>? keyResponsibilities;
  final String? employerPhone;

  Jobs({
    this.id,
    this.jobTitle,
    this.jobDescription,
    this.firstType,
    this.secondType,
    this.salaryRange,
    this.companyName,
    this.companyAddress,
    this.keyResponsibilities,
    this.employerPhone,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) {
    List<String>? responsibilities;
    final raw = json['key_responsibilities'];
    if (raw != null) {
      if (raw is List) {
        responsibilities = List<String>.from(raw);
      } else if (raw is String) {
        try {
          responsibilities = List<String>.from(jsonDecode(raw));
        } catch (e) {
          responsibilities = null;
        }
      }
    } else {
      responsibilities = null;
    }
    return Jobs(
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
      jobTitle: json['job_title'] as String?,
      jobDescription: json['job_description'] as String?,
      firstType: json['first_type'] as String?,
      secondType: json['second_type'] as String?,
      salaryRange: json['salary_range'] as String?,
      companyName: json['company_name'] as String?,
      companyAddress: json['company_address'] as String?,
      keyResponsibilities: responsibilities,
      employerPhone: json['employer_phone'] as String?,
    );
  }
}
