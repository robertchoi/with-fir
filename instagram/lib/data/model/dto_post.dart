class DtoPost {
  int? id;
  String? userName;
  String? userProfile;
  String? titleText;
  String? imageUrl;
  DateTime? createdAt;

  DtoPost({
    this.id,
    this.userName,
    this.userProfile,
    this.titleText,
    this.imageUrl,
    this.createdAt,
  });


  DtoPost.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userName = json['userName'],
        userProfile = json['userProfile'],
        titleText = json['titleText'],
        imageUrl = json['imageUrl'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'userName' : userName,
        'userProfile': userProfile,
        'titleText': titleText,
        'imageUrl': imageUrl,
        'createdAt': createdAt,
      };

}
