class PostModel {
  String? postId;
  String? name;
  String? uid;
  String? profileImg;
  String? date;
  String? postText;
  int? likeCount;
  int? commentCount;
  int? contentCount;
  List<Content>? contents;
  bool? isLiked;
  List<String>? likeArray;

  PostModel(
      {this.postId,
      this.name,
      this.uid,
      this.profileImg,
      this.date,
      this.postText,
      this.likeCount,
      this.commentCount,
      this.likeArray,
      this.contentCount,
      this.contents,
      this.isLiked = false});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    name = json['name'];
    uid = json['uid'];
    profileImg = json['profileImg'];
    date = json['date'];
    postText = json['postText'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    contentCount = json['contentCount'];
    isLiked = json['isLiked'] ?? false;
    if (json['contents'] != null) {
      contents = <Content>[];
      json['contents'].forEach((v) {
        contents!.add(Content.fromJson(v));
      });
    }
    if (json['likeArr'] != null) {
      contents = <Content>[];
      json['likeArr'].forEach((v) {
        likeArray!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['name'] = name;
    data['uid'] = uid;
    data['profileImg'] = profileImg;
    data['date'] = date;
    data['postText'] = postText;
    data['likeCount'] = likeCount;
    data['commentCount'] = commentCount;
    data['contentCount'] = contentCount;
    data['isLiked'] = isLiked;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? contentId;
  String? type;
  String? source;

  Content({this.contentId, this.type, this.source});

  Content.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    type = json['type'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentId'] = contentId;
    data['type'] = type;
    data['source'] = source;
    return data;
  }
}
