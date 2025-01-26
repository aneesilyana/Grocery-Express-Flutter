class Shop {
  int shop_id;
  int user_id;
  String shop_name;
  String description;
  String? created_at;
  String? updated_at;
  String status;
  String contact_info;
  String location;

  Shop(
    this.shop_id,
    this.user_id,
    this.shop_name,
    this.description,
    this.created_at,
    this.updated_at,
    this.status,
    this.contact_info,
    this.location,
  );

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        int.parse(json["shop_id"]),
        int.parse(json["user_id"]),
        json["shop_name"],
        json["description"],
        json["created_at"],
        json["updated_at"],
        json["status"],
        json["contact_info"],
        json["location"],
      );

  Map<String, dynamic> toJson() => {
        'shop_id': shop_id.toString(),
        'user_id': user_id.toString(),
        'shop_name': shop_name,
        'description': description,
        if (created_at != null) 'created_at': created_at,
        if (updated_at != null) 'updated_at': updated_at,
        'status': status,
        'contact_info': contact_info,
        'location': location,
      };
}
