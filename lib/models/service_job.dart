import 'invoice_item.dart';

class ServiceJob {
  final String id;
  final String customerName;
  final String vehicleNo;
  final String mobile;
  final DateTime date;
  final List<InvoiceItem> items;
  final String status; // 'Pending', 'Completed', 'Paid'
  final bool applyGst;
  final String? address;

  const ServiceJob({
    required this.id,
    required this.customerName,
    required this.vehicleNo,
    required this.mobile,
    required this.date,
    required this.items,
    required this.status,
    this.applyGst = false,
    this.address,
  });

  double get subTotal => items.fold(0, (sum, item) => sum + item.amount);
  double get total => applyGst ? subTotal * 1.18 : subTotal;

  ServiceJob copyWith({
    String? customerName,
    String? vehicleNo,
    String? mobile,
    DateTime? date,
    List<InvoiceItem>? items,
    String? status,
    bool? applyGst,
    String? address,
  }) {
    return ServiceJob(
      id: id,
      customerName: customerName ?? this.customerName,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      mobile: mobile ?? this.mobile,
      date: date ?? this.date,
      items: items ?? this.items,
      status: status ?? this.status,
      applyGst: applyGst ?? this.applyGst,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'customerName': customerName,
    'vehicleNo': vehicleNo,
    'mobile': mobile,
    'date': date.toIso8601String(),
    'items': items.map((x) => x.toJson()).toList(),
    'status': status,
    'applyGst': applyGst,
    'address': address,
  };

  factory ServiceJob.fromJson(Map<String, dynamic> json) => ServiceJob(
    id: json['id'],
    customerName: json['customerName'],
    vehicleNo: json['vehicleNo'],
    mobile: json['mobile'],
    date: DateTime.parse(json['date']),
    items: (json['items'] as List).map((i) => InvoiceItem.fromJson(i)).toList(),
    status: json['status'],
    applyGst: json['applyGst'] ?? false,
    address: json['address'],
  );
}
