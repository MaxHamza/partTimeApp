class Jobs{
  final int id;
  final String jobTitle;
  final String jobDescription;
  final String firstType;
  final String secondType;
  final String salaryRange;
  final String companyName;
  final String companyAddress;
  final List<String> keyResponsibilities;
  final String employerPhone;

  Jobs({
  required this.id,
  required this.jobTitle,
  required this.jobDescription,
  required this.firstType,
  required this.secondType,
  required this.salaryRange,
  required this.companyName,
  required this.companyAddress,
  required this.keyResponsibilities,
  required this.employerPhone,
  });

  factory Jobs.fromJson(Map<String, dynamic> json) {
  return Jobs(
  id: json['id'],
  jobTitle: json['job_title'],
  jobDescription: json['job_description'],
  firstType: json['first_type'],
  secondType: json['second_type'],
  salaryRange: json['salary_range'],
  companyName: json['company_name'],
  companyAddress: json['company_address'],
  keyResponsibilities: List<String>.from(json['key_responsibilities']),
  employerPhone: json['employer_phone'],
  );
  }
  }
