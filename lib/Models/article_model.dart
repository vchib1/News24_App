class ArticlesModel{
  final String title;
  final String urlToImage;
  final String url;

  const ArticlesModel({
    required this.title,
    required this.urlToImage,
    required this.url,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic>json){
    return ArticlesModel(
      title: json['title'] ?? "",
      url: json['url'] ?? "https://colorlib.com/wp/wp-content/uploads/sites/2/404-error-page-templates.jpg.webp",
      urlToImage: json['urlToImage'] ?? "https://img.freepik.com/premium-vector/newspaper-hand-drawn-outline-doodle-icon_107173-17674.jpg",
    );
  }

}
