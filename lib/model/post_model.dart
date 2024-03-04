class Post {
  int? id;
  String? title;
  String? body;

  Post({this.id, this.title, this.body});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'body': body};
  }

  static Post fromMap(Map map) {
    Post post = Post();
    post.id = map['id'];
    post.title = map['title'];
    post.body = map['body'];
    return post;
  }
}
