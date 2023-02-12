class User {
  String? id;
  String? fullname;
  String? email;
  String? pwd;
  String? pic;
  bool? isVerified;
  int? otp;

  User(
      {this.id,
        this.fullname,
        this.email,
        this.pwd,
        this.pic,
        this.isVerified,
        this.otp,
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
    data['_id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['pwd'] = this.pwd;
    data['pic'] = this.pic;
    data['isVerified'] = this.isVerified;
    data['otp'] = this.otp;
    return data;
  }

  @override
  String toString() {
    return 'User{Id: $id, fullname: $fullname, email: $email, pwd: $pwd, pic: $pic, isVerified: $isVerified, otp: $otp}';
  }
}