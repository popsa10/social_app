class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String bio;
  bool isEmailVerified;
  String image;
  String cover;
  String token;

  SocialUserModel(
      {this.email,
      this.name,
      this.phone,
      this.bio,
      this.uId,
      this.token,
      this.isEmailVerified,
      this.image,
      this.cover});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    bio = json['bio'];
    uId = json['uid'];
    isEmailVerified = json['isEmailVerified'];
    image = json["image"];
    cover = json["cover"];
    token = json["token"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uId,
      'name': name,
      'email': email,
      "bio": bio,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
      "image": image,
      "cover": cover,
      "token": token,
    };
  }
}
