class PostDay4Model {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostDay4Model({this.userId, this.id, this.title, this.body});

  PostDay4Model.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}