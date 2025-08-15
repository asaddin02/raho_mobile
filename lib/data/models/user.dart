class User {
  final String id;
  final String name;
  final String partnerName;

  const User({required this.id, required this.name, required this.partnerName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      partnerName: json['partner_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'partner_name': partnerName};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.name == name &&
        other.partnerName == partnerName;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ partnerName.hashCode;
}
