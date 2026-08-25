class InventoryItem {
  final String name;
  final String sku;
  final int stock;
  final String price;

  const InventoryItem({
    required this.name,
    required this.sku,
    required this.stock,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sku': sku,
    'stock': stock,
    'price': price,
  };

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
    name: json['name'],
    sku: json['sku'],
    stock: json['stock'],
    price: json['price'],
  );

  InventoryItem copyWith({
    String? name,
    String? sku,
    int? stock,
    String? price,
  }) {
    return InventoryItem(
      name: name ?? this.name,
      sku: sku ?? this.sku,
      stock: stock ?? this.stock,
      price: price ?? this.price,
    );
  }
}
