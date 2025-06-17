class User {
  final String? user_name;
  final String? country;
  final String? job_title;
  final String? password;
  final String? phone_number;
  final String? image;
  final String? cv;
  final String? email;
  User({this.user_name,this.country,this.password,this.image,this.email,this.cv,this.job_title,this.phone_number});
factory User.fromJson(Map<String,dynamic>json){
  return User(
    email: json['email'],
    user_name: json['user_name'],
    country:json['country'] ,
    cv: json['cv'],
    image:json['image'] ,
    job_title: json['job_title'],
    password: json['password'],
    phone_number: json['phone_number'],
  );
}
}
