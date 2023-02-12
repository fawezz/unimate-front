class User {
  String? sId;
  String? fullname;
  String? email;
  String? pwd;
  String? pic;
  bool? isVerified;
  int? otp;

  User(
      {this.sId,
        this.fullname,
        this.email,
        this.pwd,
        this.pic,
        this.isVerified,
        this.otp,
       });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    pwd = json['pwd'];
    pic = json['pic'];
    isVerified = json['isVerified'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    return 'User{Id: $sId, fullname: $fullname, email: $email, pwd: $pwd, pic: $pic, isVerified: $isVerified, otp: $otp}';
  }
}