class FeedbackModel {
  String name;
  String url;

  FeedbackModel({this.name, this.url});

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      name: "${json['name']}",
      url: "${json['url']}",
    );
  }

  Map toJson() => {
        "name": name,
        "url": url,
      };
}
