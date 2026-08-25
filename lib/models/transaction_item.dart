import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'invoice_item.dart';

class TransactionItem {
  final String id;
  final String type;
  final String party;
  final String date;
  final String amount;
  final String status;
  final String category;
  final IconData icon;
  final Color color;
  final Color background;
  final bool positive;
  final List<InvoiceItem>? items;
  final bool applyGst;
  final String? customerAddress;
  final String? customerGst;

  const TransactionItem({
    required this.id,
    required this.type,
    required this.party,
    required this.date,
    required this.amount,
    required this.status,
    required this.category,
    required this.icon,
    required this.color,
    required this.background,
    this.positive = false,
    this.items,
    this.applyGst = false,
    this.customerAddress,
    this.customerGst,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'party': party,
    'date': date,
    'amount': amount,
    'status': status,
    'category': category,
    'positive': positive,
    'items': items?.map((x) => x.toJson()).toList(),
    'applyGst': applyGst,
    'customerAddress': customerAddress,
    'customerGst': customerGst,
  };

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    final category = json['category'];
    IconData icon;
    Color color;
    Color background;

    if (category == 'sales') {
      icon = Icons.description_outlined;
      color = AppColors.primary;
      background = AppColors.primarySoft;
    } else if (category == 'purchases') {
      icon = Icons.receipt_long_outlined;
      color = AppColors.purple;
      background = AppColors.purpleSoft;
    } else if (category == 'expenses') {
      icon = Icons.request_quote_outlined;
      color = AppColors.amber;
      background = AppColors.amberSoft;
    } else {
      icon = Icons.account_balance_wallet_outlined;
      color = AppColors.green;
      background = AppColors.greenSoft;
    }

    return TransactionItem(
      id: json['id'],
      type: json['type'],
      party: json['party'],
      date: json['date'],
      amount: json['amount'],
      status: json['status'],
      category: category,
      icon: icon,
      color: color,
      background: background,
      positive: json['positive'] ?? false,
      items: json['items'] != null 
          ? (json['items'] as List).map((i) => InvoiceItem.fromJson(i)).toList()
          : null,
      applyGst: json['applyGst'] ?? false,
      customerAddress: json['customerAddress'],
      customerGst: json['customerGst'],
    );
  }

  TransactionItem copyWith({
    String? id,
    String? type,
    String? party,
    String? date,
    String? amount,
    String? status,
    String? category,
    IconData? icon,
    Color? color,
    Color? background,
    bool? positive,
    List<InvoiceItem>? items,
    bool? applyGst,
    String? customerAddress,
    String? customerGst,
  }) {
    return TransactionItem(
      id: id ?? this.id,
      type: type ?? this.type,
      party: party ?? this.party,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      background: background ?? this.background,
      positive: positive ?? this.positive,
      items: items ?? this.items,
      applyGst: applyGst ?? this.applyGst,
      customerAddress: customerAddress ?? this.customerAddress,
      customerGst: customerGst ?? this.customerGst,
    );
  }
}
