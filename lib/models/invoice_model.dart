import 'package:balamurugan_erp/models/invoice_item.dart';
import 'package:balamurugan_erp/models/company_profile.dart';

class InvoiceModel {
  final String id;
  final DateTime date;
  final String terms;
  final DateTime dueDate;
  final CompanyProfile company;
  final String billToName;
  final String billToAddress;
  final List<InvoiceItem> items;
  final double taxRate;
  final bool applyGst;

  InvoiceModel({
    required this.id,
    required this.date,
    required this.terms,
    required this.dueDate,
    required this.company,
    required this.billToName,
    required this.billToAddress,
    required this.items,
    this.taxRate = 0.18,
    this.applyGst = false,
  });

  double get subTotal => items.fold(0, (sum, item) => sum + item.amount);
  double get taxAmount => applyGst ? subTotal * taxRate : 0;
  double get total => subTotal + taxAmount;
}
