class Vendor {
  final String name;
  final String contact;
  final String type;

  const Vendor({
    required this.name,
    required this.contact,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'contact': contact,
    'type': type,
  };

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    name: json['name'],
    contact: json['contact'],
    type: json['type'],
  );

  Vendor copyWith({
    String? name,
    String? contact,
    String? type,
  }) {
    return Vendor(
      name: name ?? this.name,
      contact: contact ?? this.contact,
      type: type ?? this.type,
    );
  }
}
