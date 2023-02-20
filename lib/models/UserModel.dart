class User {
  String? id;
  String? fullname;
  String? email;
  String? pwd;
  String? pic;
  bool? isVerified;
  int? otp;

  User({
    id,
    fullname,
    email,
    pwd,
    pic,
    isVerified,
    otp,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    pwd = json['pwd'];
    pic = json['pic'];
    isVerified = json['isVerified'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['pwd'] = pwd;
    data['pic'] = pic;
    data['isVerified'] = isVerified;
    data['otp'] = otp;
    return data;
  }

  @override
  String toString() {
    return 'User{Id: $id, fullname: $fullname, email: $email, pwd: $pwd, pic: $pic, isVerified: $isVerified, otp: $otp}';
  }
}
