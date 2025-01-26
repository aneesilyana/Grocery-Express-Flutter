class Product {
  int product_id;
  int shop_id;
  String product_name;
  String price;
  String quantity;
  String description;
  String? created_at;
  String? updated_at;
  String status;
  String category;
  String image_file;
  String distance;
  String avg_rating;
  String shop_name;

  Product(
    this.product_id,
    this.shop_id,
    this.product_name,
    this.price,
    this.quantity,
    this.description,
    this.created_at,
    this.updated_at,
    this.status,
    this.category,
    this.image_file,
    this.distance,
    this.avg_rating,
    this.shop_name,
  );

  // factory Product.fromJson(Map<String, dynamic> json) => Product(
  //       json["product_id"] is int
  //           ? json["product_id"]
  //           : int.parse(json["product_id"]), // Safely parse product_id
  //       int.parse(json["shop_id"]),
  //       json["product_name"],
  //       json["price"],
  //       json["quantity"],
  //       json["description"],
  //       json["created_at"],
  //       json["updated_at"],
  //       json["status"],
  //       json["category"],
  //       json["image_file"],
  //       json["distance"],
  //       json["avg_rating"],
  //     );
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        int.parse(json["product_id"].toString()),
        int.parse(json["shop_id"].toString()),
        json["product_name"].toString(),
        json["price"].toString(),
        json["quantity"].toString(),
        json["description"].toString(),
        json["created_at"]?.toString(),
        json["updated_at"]?.toString(),
        json["status"].toString(),
        json["category"].toString(),
        json["image_file"].toString(),
        json["distance"].toString(),
        json["avg_rating"].toString(),
        json["shop_name"].toString(),
      );

  Map<String, String> toJson() => {
        'product_id': product_id.toString(),
        'shop_id': shop_id.toString(),
        'product_name': product_name,
        'price': price,
        'quantity': quantity,
        'description': description,
        if (created_at != null) 'created_at': created_at!,
        if (updated_at != null) 'updated_at': updated_at!,
        'status': status,
        'category': category,
        'distance': distance,
        'image_file': image_file,
        'avg_rating': avg_rating,
      };
}
