import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageURL;
  final String title;
  final String? description;
  final String? type;
  final String? city;
  final String?category;
  final String? recommendation;
  final List<int>? ratings;
  final List<String>? comments;
  bool? isFavorite;

  Post({
    required this.id,
    required this.imageURL,
    required this.title,
    this.description,
    this.type,
    this.city,
    this.category,
    this.recommendation,
    this.ratings,
    this.comments,
    this.isFavorite = false,
  });

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Post(
      id: data['id'],
      imageURL: data['imageURL'],
      title: data['title'],
      description: data['description'],
      type: data['type'],
      city: data['city'],
      category: data['category'],
      recommendation: data['recommendation'],
      ratings: List<int>.from(data['ratings'] ?? []),
      comments: List<String>.from(data['comments'] ?? []),
      isFavorite: data['isFavorite'] ?? false,
    );
  }
}