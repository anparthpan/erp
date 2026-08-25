import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/customer.dart';

class CustomersScreen extends StatelessWidget {
  final bool compact;
  final List<Customer> customers;
  final VoidCallback onCreate;
  final Function(Customer) onEdit;
  final Function(Customer) onDelete;

  const CustomersScreen({
    super.key,
    required this.compact,
    required this.customers,
    required this.onCreate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'CUSTOMERS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.person_add_outlined),
              label: const Text('ADD CUSTOMER'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.line),
          ),
          child: Column(
            children: customers.map<Widget>((customer) {
              final isLast = customers.indexOf(customer) == customers.length - 1;
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primarySoft,
                      child: Text(
                        customer.name[0].toUpperCase(),
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          customer.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                        ),
                        if (customer.gstNumber.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.line,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'GST: ${customer.gstNumber}'.toUpperCase(),
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.phone_outlined, size: 14, color: AppColors.muted),
                            const SizedBox(width: 4),
                            Text(customer.mobile.isNotEmpty ? customer.mobile : 'NO MOBILE', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 12),
                            const Icon(Icons.email_outlined, size: 14, color: AppColors.muted),
                            const SizedBox(width: 4),
                            Text(customer.email.toUpperCase(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        if (customer.address.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.muted),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  customer.address.toUpperCase(),
                                  style: const TextStyle(fontSize: 12, color: AppColors.muted, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              customer.balance,
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.ink),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              customer.status.toUpperCase(),
                              style: TextStyle(
                                color: customer.status.toUpperCase() == 'OVERDUE' ? AppColors.red : AppColors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') {
                              onEdit(customer);
                            } else if (value == 'delete') {
                              onDelete(customer);
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: ListTile(
                                leading: Icon(Icons.edit_outlined),
                                title: Text('EDIT'),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete_outline, color: AppColors.red),
                                title: Text('DELETE', style: TextStyle(color: AppColors.red)),
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) const Divider(height: 1, color: AppColors.line),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
