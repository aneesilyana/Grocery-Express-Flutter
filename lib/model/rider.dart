class rider {
  int rider_id;
  int user_id;
  String vehicle_type;
  String license_plate;
  String availability;
  String? assigned_order_id;
  String? created_at;
  String? updated_at;

  rider(
    this.rider_id,
    this.user_id,
    this.vehicle_type,
    this.license_plate,
    this.availability,
    this.assigned_order_id,
    this.created_at,
    this.updated_at,
  );

  factory rider.fromJson(Map<String, dynamic> json) => rider(
        int.parse(json["rider_id"]),
        int.parse(json["user_id"]),
        json["vehicle_type"],
        json["license_plate"],
        json["availability"],
        json["assigned_order_id"],
        json["created_at"],
        json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        'rider_id': rider_id.toString(),
        'user_id': user_id.toString(),
        'vehicle_type': vehicle_type,
        'license_plate': license_plate,
        'availability': availability,
        if (assigned_order_id != null) 'assigned_order_id': assigned_order_id,
        if (created_at != null) 'created_at': created_at,
        if (updated_at != null) 'updated_at': updated_at,
      };
}
