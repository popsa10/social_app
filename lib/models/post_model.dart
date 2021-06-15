class PostModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String text;
  String postImage;

  PostModel({
    this.text,
    this.name,
    this.dateTime,
    this.uId,
    this.postImage,
    this.image,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    dateTime = json["dateTime"];
    postImage = json["postImage"];
    text = json["text"];
    image = json["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uId,
      "image": image,
      'name': name,
      "text": text,
      "postImage": postImage,
      "dateTime": dateTime,
    };
  }
}
