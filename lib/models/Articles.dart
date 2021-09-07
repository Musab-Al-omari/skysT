import 'package:flutter/foundation.dart';

class Articles with ChangeNotifier {
  final String id;
  final String title;
  final String author;
  final String description;
  final String publishedAt;
  final String imageUrl;
  bool isFavorite;

  Articles({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.publishedAt,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
