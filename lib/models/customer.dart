class Customer {
  final String name;
  final String email;
  final String balance;
  final String status;
  final String address;
  final String gstNumber;
  final String mobile;

  const Customer({
    required this.name,
    required this.email,
    required this.balance,
    required this.status,
    required this.address,
    required this.gstNumber,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'balance': balance,
    'status': status,
    'address': address,
    'gstNumber': gstNumber,
    'mobile': mobile,
  };

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json['name'],
    email: json['email'],
    balance: json['balance'],
    status: json['status'],
    address: json['address'] ?? '',
    gstNumber: json['gstNumber'] ?? '',
    mobile: json['mobile'] ?? '',
  );

  Customer copyWith({
    String? name,
    String? email,
    String? balance,
    String? status,
    String? address,
    String? gstNumber,
    String? mobile,
  }) {
    return Customer(
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      address: address ?? this.address,
      gstNumber: gstNumber ?? this.gstNumber,
      mobile: mobile ?? this.mobile,
    );
  }
}
