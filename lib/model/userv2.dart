// class Users {
//   int user_id;
//   String username;
//   String fname;
//   String email;
//   String phonenum;
//   String password;
//   String address;
//   String? created_at;
//   int role_id;

//   Users(
//     this.user_id,
//     this.username,
//     this.fname,
//     this.email,
//     this.phonenum,
//     this.password,
//     this.address,
//     this.created_at,
//     this.role_id,
//   );

//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//         int.parse(json["user_id"]),
//         json["username"],
//         json["fname"],
//         json["email"],
//         json["phonenum"],
//         json["password"],
//         json["address"],
//         json["created_at"] ?? "",
//         int.parse(json["role_id"]),
//         // int.parse(json["role_id"].toString()),
//       );

//   // factory Users.fromJson(Map<String, dynamic> json) {
//   //   if (json["user_id"] == null ||
//   //       json["username"] == null ||
//   //       json["fname"] == null ||
//   //       json["email"] == null ||
//   //       json["phonenum"] == null ||
//   //       json["password"] == null ||
//   //       json["address"] == null ||
//   //       json["created_at"] == null ||
//   //       json["role_id"] == null) {
//   //     throw FormatException("One or more required fields are null.");
//   //   }

//   //   return Users(
//   //     int.parse(json["user_id"].toString()), // Ensure user_id is an int
//   //     json["username"], // Assign directly (not null)
//   //     json["fname"], // Assign directly (not null)
//   //     json["email"],
//   //     json["phonenum"],
//   //     json["password"],
//   //     json["address"],
//   //     json["created_at"],
//   //     int.parse(json["role_id"].toString()), // Ensure role_id is an int
//   //   );
//   // }

//   Map<String, dynamic> toJson() => {
//         'user_id': user_id.toString(),
//         'username': username,
//         'fname': fname,
//         'email': email,
//         'phonenum': phonenum,
//         'password': password,
//         'address': address,
//         'created_at': created_at,
//         'role_id': role_id.toString(),
//       };
// }

class Users {
  int user_id;
  String username;
  String fname;
  String email;
  String phonenum;
  String password;
  String address;
  String? created_at; // Nullable
  int role_id;

  Users(
    this.user_id,
    this.username,
    this.fname,
    this.email,
    this.phonenum,
    this.password,
    this.address,
    this.created_at,
    this.role_id,
  );

  factory Users.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json["user_id"] == null ||
        json["username"] == null ||
        json["fname"] == null ||
        json["email"] == null ||
        json["phonenum"] == null ||
        json["password"] == null ||
        json["address"] == null ||
        json["role_id"] == null) {
      throw FormatException("One or more required fields are null.");
    }

    return Users(
      int.parse(json["user_id"].toString()),
      json["username"],
      json["fname"],
      json["email"],
      json["phonenum"],
      json["password"],
      json["address"],
      json["created_at"], // Nullable field, defaults to null
      int.parse(json["role_id"].toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id.toString(),
        'username': username,
        'fname': fname,
        'email': email,
        'phonenum': phonenum,
        'password': password,
        'address': address,
        'created_at': created_at, // Can be null
        'role_id': role_id.toString(),
      };
}
