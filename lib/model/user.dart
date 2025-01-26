class User {
  int id;
  String username;
  String? fname;
  String email;
  String? phonenum;
  String password;
  String? address;
  String created_at;
  // DateTime created_at;

  User(
    this.id,
    this.username,
    this.fname,
    this.email,
    this.phonenum,
    this.password,
    this.address,
    this.created_at,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
        int.parse(json["id"]),
        json["username"],
        json["fname"],
        json["email"],
        json["phonenum"],
        json["password"],
        json["address"],
        json["created_at"],
        // DateTime.parse(
        //     json["created_at"]), // Parse timestamp string into DateTime
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      // if (username != null)
      'username': username,
      if (fname != null) 'fname': fname, // Only include if not null
      'email': email,
      if (phonenum != null) 'phonenum': phonenum, // Only include if not null
      'password': password,
      if (address != null) 'address': address, // Only include if not null
      // if (created_at != null)
      'created_at': created_at, // Only include if not null
      // 'created_at':
      //     created_at.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
} //RegistrationUser Successful using this code
