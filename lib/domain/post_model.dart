class PostModel {
  String? message;
  List<PostData> data = [];
  PostModel();
  PostModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    json["data"].forEach((element) {
      data.add(PostData.fromJson(element));
    });
  }
}

class PostData {
  String ? forumId;
  String ? title;
  String ? description;
  String ? imageUrl;
  String ? userId;
  List<PostLikes> forumLikes = [];
  List<PostComments> forumComments = [];
  late UserData user;
  PostData.fromJson(Map<String, dynamic> json) {
    forumId = json["forumId"];
    title = json["title"];
    description = json["description"];
    imageUrl = json["imageUrl"];
    userId = json["userId"];
    json["ForumLikes"].forEach((element) {
      forumLikes.add(PostLikes.fromJson(element));
    });
    json["ForumComments"].forEach((element) {
      forumComments.add(PostComments.fromJson(element));
    });
    user = UserData.fromJson(json["user"]);
  }
}

class PostLikes {
  String ? forumId;
  String ? userId;
  PostLikes.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    forumId = json["forumId"];
  }
}

class PostComments {
  String ? forumCommentId;
  String ? forumId;
  String ? userId;
  String ? comment;
  String ? createdAt;
  PostComments.fromJson(Map<String, dynamic> json) {
    forumCommentId = json["forumCommentId"];
    forumId = json["forumId"];
    userId = json["userId"];
    comment = json["comment"];
    createdAt = json["createdAt"];
  }
}

class UserData {
 late  String firstName;
 late  String lastName;
 late  String imageUrl;

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json["firstName"];
    lastName = json["lastName"];
    imageUrl = json["imageUrl"];
  }
}
