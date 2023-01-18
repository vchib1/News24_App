class CategoryNewsModel{
  final String author;
  final String title;
  final String description;
  final String content;
  final String urlToImage;
  final String url;

  const CategoryNewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.content,
    required this.urlToImage,
    required this.url,
  });

  factory CategoryNewsModel.fromJson(Map<String, dynamic>json){
    return CategoryNewsModel(
      title: json['title'] ?? "",
      author: json['author'] ?? "",
      content: json['content'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "https://img.freepik.com/premium-vector/newspaper-hand-drawn-outline-doodle-icon_107173-17674.jpg",
    );
  }

}