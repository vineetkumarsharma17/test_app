// To parse this JSON data, do
//
//     final vegitable = vegitableFromJson(jsonString);

class Vegetable {
  final String? id;
  final String? name;
  final String? price;
  final String? details;
  final String? weight;
  final String? image;
  Vegetable({
    this.id,
    this.name,
    this.price,
    this.details,
    this.weight,
    this.image,
  });

  factory Vegetable.fromJson(Map<String, dynamic> json) => Vegetable(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        details: json["details"],
        weight: json["weight"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "details": details,
        "weight": weight,
        "image": image,
      };
}
