import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';

class ExpensesScreen extends StatelessWidget {
  final bool compact;
  final List<TransactionItem> expenses;
  final VoidCallback onCreate;
  final Function(TransactionItem) onEdit;
  final Function(TransactionItem) onDelete;

  const ExpensesScreen({
    super.key,
    required this.compact,
    required this.expenses,
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
              'EXPENSES',
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
              label: const Text('ADD EXPENSE'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        expenses.isEmpty
            ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('NO EXPENSES FOUND.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold))))
            : Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expenses.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.line),
                  itemBuilder: (context, index) {
                    final item = expenses[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: item.background,
                        child: Icon(item.icon, color: item.color, size: 20),
                      ),
                      title: Text(item.party.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink)),
                      subtitle: Text('${item.id} • ${item.date}'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.amount,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.red),
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
