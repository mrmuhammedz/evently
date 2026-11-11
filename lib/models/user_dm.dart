class UserDm {
  String id;
  String name;
  String email;
  String? photoUrl;
  List<String> favoritesEvents;

  UserDm({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    List<String>? favoritesEvents,
  }) : favoritesEvents = List<String>.from(favoritesEvents ?? []);

  UserDm.fromJson(Map<String, dynamic> map)
    : id = map["id"],
      name = map["name"],
      email = map["email"],
      photoUrl = map["photoUrl"],
      favoritesEvents = List<String>.from(map["favoritesEvents"] ?? []);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
      "favoritesEvents": favoritesEvents,
    };
  }
}
