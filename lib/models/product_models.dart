import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String discount;
  final Color? discountColor;
  bool isWishlist;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.discount = "",
    this.discountColor,
    this.isWishlist = false,
    this.category = "Unisex",
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? image,
    String? discount,
    Color? discountColor,
    bool? isWishlist,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      discount: discount ?? this.discount,
      discountColor: discountColor ?? this.discountColor,
      isWishlist: isWishlist ?? this.isWishlist,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': '\$${price.toInt()}',
      'rawPrice': price,
      'image': image,
      'discount': discount,
      'discountColor': discountColor,
      'isFavorite': isWishlist,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    double parsedPrice = 0.0;
    if (map['rawPrice'] != null && map['rawPrice'] is num) {
      parsedPrice = (map['rawPrice'] as num).toDouble();
    } else if (map['price'] != null) {
      if (map['price'] is num) {
        parsedPrice = (map['price'] as num).toDouble();
      } else {
        final clean = map['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '');
        parsedPrice = double.tryParse(clean) ?? 0.0;
      }
    }

    return Product(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      price: parsedPrice,
      image: map['image']?.toString() ?? 'assets/images/pic1.png',
      discount: map['discount']?.toString() ?? map['sale']?.toString() ?? '',
      discountColor: map['discountColor'] is Color ? map['discountColor'] as Color : null,
      isWishlist: map['isFavorite'] == true || map['isWishlist'] == true || map['fav'] == true,
      category: map['category']?.toString() ?? 'Unisex',
    );
  }
}
