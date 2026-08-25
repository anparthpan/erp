import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';

class BillsScreen extends StatelessWidget {
  final bool compact;
  final List<TransactionItem> bills;
  final VoidCallback onCreate;
  final Function(TransactionItem) onEdit;
  final Function(TransactionItem) onDelete;

  const BillsScreen({
    super.key,
    required this.compact,
    required this.bills,
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
              'BILLS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
              label: const Text('NEW BILL'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        bills.isEmpty
            ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('NO BILLS FOUND.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold))))
            : Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bills.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.line),
                  itemBuilder: (context, index) {
                    final item = bills[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: item.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(item.icon, color: item.color),
                      ),
                      title: Text(item.party.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink)),
                      subtitle: Text('${item.id} • DUE ${item.date}'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.amount,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                onEdit(item);
                              } else if (value == 'delete') {
                                onDelete(item);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text('EDIT')),
                              const PopupMenuItem(value: 'delete', child: Text('DELETE', style: TextStyle(color: AppColors.red))),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
