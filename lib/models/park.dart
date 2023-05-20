class Park {
  Park({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory Park.fromJson(Map<String, dynamic> json) => Park(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
  int id;
  String name;
  String address;
  String latitude;
  String longitude;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };
}
