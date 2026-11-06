class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String category;
  final double rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Tanpa judul',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num? ?? 0).toDouble(),
      thumbnail: json['thumbnail'] as String? ?? '',
      category: json['category'] as String? ?? '-',
      rating: (json['rating'] as num? ?? 0).toDouble(),
    );
  }
}
