class InvoiceItem {
  final String description;
  final String subDescription;
  final String? hsnCode;
  final double quantity;
  final String unit;
  final double rate;

  InvoiceItem({
    required this.description,
    required this.subDescription,
    this.hsnCode,
    required this.quantity,
    required this.unit,
    required this.rate,
  });

  double get amount => quantity * rate;

  Map<String, dynamic> toJson() => {
    'description': description,
    'subDescription': subDescription,
    'hsnCode': hsnCode,
    'quantity': quantity,
    'unit': unit,
    'rate': rate,
  };

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
    description: json['description'],
    subDescription: json['subDescription'],
    hsnCode: json['hsnCode'],
    quantity: (json['quantity'] as num).toDouble(),
    unit: json['unit'],
    rate: (json['rate'] as num).toDouble(),
  );

  InvoiceItem copyWith({
    String? description,
    String? subDescription,
    String? hsnCode,
    double? quantity,
    String? unit,
    double? rate,
  }) {
    return InvoiceItem(
      description: description ?? this.description,
      subDescription: subDescription ?? this.subDescription,
      hsnCode: hsnCode ?? this.hsnCode,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      rate: rate ?? this.rate,
    );
  }
}
