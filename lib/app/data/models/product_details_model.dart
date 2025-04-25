import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? image;
  Rating? rating;

  ProductDetailsModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.rating,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    id: json["id"],
    title: json["title"],
    price: (json["price"] as num).toDouble(),
    description: json["description"],
    image: json["image"],
    rating: Rating.fromJson(json["rating"]),
    );

  Map<String, dynamic> toJson() => {
    "id": id,
     "title": title,
     "price": price,
     "description": description,
     "image": image,
     "rating": rating?.toJson(),
     };
}

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: (json["rate"] as num).toDouble(),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };
}