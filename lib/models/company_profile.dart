class CompanyProfile {
  final String name;
  final String address;
  final String gstNumber;
  final String currency;
  final String email;
  final String phone;

  CompanyProfile({
    required this.name,
    required this.address,
    required this.gstNumber,
    required this.currency,
    required this.email,
    required this.phone,
  });

  CompanyProfile copyWith({
    String? name,
    String? address,
    String? gstNumber,
    String? currency,
    String? email,
    String? phone,
  }) {
    return CompanyProfile(
      name: name ?? this.name,
      address: address ?? this.address,
      gstNumber: gstNumber ?? this.gstNumber,
      currency: currency ?? this.currency,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
