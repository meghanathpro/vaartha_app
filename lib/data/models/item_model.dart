class ItemModel {
  final String id;
  final String datetime;
  final String category;
  final String source;
  final String content;
  final String articleLink;
  final String imageLink;

  ItemModel.fromJson(Map<dynamic, dynamic> parsedJson)
      : id = parsedJson['id'],
        datetime = parsedJson['datetime'],
        category = parsedJson['category'],
        source = parsedJson['source'],
        content = parsedJson['content'],
        articleLink = parsedJson['article_link'],
        imageLink = parsedJson['image_link'];

  DateTime get datetimeDart {
    return DateTime.parse(datetime);
  }

  String get imagesLink {
    return removeSubstringBetweenUnderscoreAndDot(imageLink);
  }
}

String removeSubstringBetweenUnderscoreAndDot(String url) {
  int underscoreIndex = url.indexOf('_');
  int dotIndex = url.lastIndexOf('.');

  if (underscoreIndex != -1 && dotIndex != -1 && dotIndex > underscoreIndex) {
    return url.substring(0, underscoreIndex) + url.substring(dotIndex);
  }

  return url;
}
