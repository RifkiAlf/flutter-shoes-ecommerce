import 'package:flutter/material.dart';
import '../models/product_models.dart';

class WishlistManager extends ChangeNotifier {
  static final WishlistManager _instance = WishlistManager._internal();
  static WishlistManager get instance => _instance;
  factory WishlistManager() => _instance;

  WishlistManager._internal();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  int get count => _items.length;

  bool isFavorite({String? id, String? name, String? image}) {
    return _items.any((item) {
      if (id != null && id.isNotEmpty && item.id.isNotEmpty && item.id == id) {
        return true;
      }
      if (name != null &&
          name.isNotEmpty &&
          item.name.isNotEmpty &&
          item.name.toLowerCase() == name.toLowerCase()) {
        return true;
      }
      if (image != null && image.isNotEmpty && item.image == image) {
        return true;
      }
      return false;
    });
  }

  bool isProductFavorite(Product product) {
    return isFavorite(id: product.id, name: product.name, image: product.image);
  }

  bool toggle(Product product) {
    final index = _items.indexWhere((item) {
      if (product.id.isNotEmpty && item.id.isNotEmpty && item.id == product.id) {
        return true;
      }
      if (product.name.isNotEmpty &&
          item.name.isNotEmpty &&
          item.name.toLowerCase() == product.name.toLowerCase()) {
        return true;
      }
      if (product.image.isNotEmpty && item.image == product.image) {
        return true;
      }
      return false;
    });

    bool nowFavorited;
    if (index >= 0) {
      _items.removeAt(index);
      nowFavorited = false;
    } else {
      _items.add(product.copyWith(isWishlist: true));
      nowFavorited = true;
    }
    notifyListeners();
    return nowFavorited;
  }

  void add(Product product) {
    if (!isProductFavorite(product)) {
      _items.add(product.copyWith(isWishlist: true));
      notifyListeners();
    }
  }

  void remove({String? id, String? name, String? image}) {
    _items.removeWhere((item) {
      if (id != null && id.isNotEmpty && item.id.isNotEmpty && item.id == id) {
        return true;
      }
      if (name != null &&
          name.isNotEmpty &&
          item.name.isNotEmpty &&
          item.name.toLowerCase() == name.toLowerCase()) {
        return true;
      }
      if (image != null && image.isNotEmpty && item.image == image) {
        return true;
      }
      return false;
    });
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

