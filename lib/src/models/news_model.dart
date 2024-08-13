class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String category;
  final String creator;
  final String link;

  NewsArticle( {
    required this.link,
    required this.creator,
    required this.category,
    required this.title,
    required this.description,
    required this.urlToImage,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      urlToImage: json['image_url'],
      category: json['category'],
      creator: json['creator'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'category': category,
      'creator': creator,
      'link': link,
    };
  }
}
