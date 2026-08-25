import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';

class PaymentsScreen extends StatelessWidget {
  final bool compact;
  final List<TransactionItem> payments;

  const PaymentsScreen({
    super.key,
    required this.compact,
    required this.payments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PAYMENTS RECEIVED',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),
        payments.isEmpty
            ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('NO PAYMENTS RECORDED.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold))))
            : Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: payments.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.line),
                  itemBuilder: (context, index) {
                    final item = payments[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: item.background,
                        child: Icon(item.icon, color: item.color, size: 20),
                      ),
                      title: Text(
                        item.party.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink),
                      ),
                      subtitle: Text('${item.id} • ${item.date}'.toUpperCase()),
                      trailing: Text(
                        item.amount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.green,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
