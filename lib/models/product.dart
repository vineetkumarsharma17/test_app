// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String? id;
  final String? name;
  final String? moq;
  final String? price;
  final String? discountedPrice;

  Product({
    this.id,
    this.name,
    this.moq,
    this.price,
    this.discountedPrice,
  });
  Product copyWith({
    String? id,
    String? name,
    String? moq,
    String? price,
    String? discountedPrice,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        moq: moq ?? this.moq,
        price: price ?? this.price,
        discountedPrice: discountedPrice ?? this.discountedPrice,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        moq: json["moq"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "moq": moq,
        "price": price,
        "discounted_price": discountedPrice,
      };
}
