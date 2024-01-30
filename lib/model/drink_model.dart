import 'package:flutter/material.dart';

class DrinkModel {
  final int id;
  final String name;
  final String img;
  final String description;
  final double price;
  final double salePrice;
  final double favorite;
  final double rating;

  final ValueNotifier<bool> isFavorite;

  DrinkModel({
    required this.id,
    required this.name,
    required this.img,
    required this.description,
    required this.price,
    required this.salePrice,
    required this.favorite,
    required this.rating,
  }) : isFavorite = ValueNotifier<bool>(false);

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'],
      price: json['price'].toDouble(),
      salePrice: json['salePrice'].toDouble(),
      favorite: json['favorite'].toDouble(),
      rating: json['rating'].toDouble(),
    );
  }
}
