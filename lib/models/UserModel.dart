class User {
  String? id;
  String? fullname;
  String? email;
  String? pic;
  bool? isVerified;
  String? role;
  bool? isBlocked;
  int? level;
  String? speciality;
  int? classe;

  User({
    id,
    fullname,
    email,
    pic,
    role,
    level,
    speciality,
    isBlocked,
    isVerified,
    classe
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullname = json['fullname'];
    email = json['email'];
    pic = json['pic'];
    isVerified = json['isVerified'];
    role = json['role'];
    isBlocked = json['isBlocked'];
    level = json['level'];
    speciality = json['speciality'];
    classe = json['classe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['pic'] = pic;
    data['isVerified'] = isVerified;
    data['role'] = role;
    data['isBlocked'] = isBlocked;
    data['level'] = level;
    data['speciality'] = speciality;
    data['classe'] = classe;
    return data;
  }

  @override
  String toString() {
    return 'User{Id: $id, fullname: $fullname, email: $email, role: $role, pic: $pic, isVerified: $isVerified, speciality: $speciality, classe: $classe}';
  }
}
