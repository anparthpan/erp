import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/mock_data.dart';
import 'package:intl/intl.dart';

class PageHeading extends StatelessWidget {
  const PageHeading({
    super.key,
    required this.selectedNav,
    required this.onCreateInvoice,
    required this.onImport,
    required this.onToast,
  });

  final int selectedNav;
  final VoidCallback onCreateInvoice;
  final VoidCallback onImport;
  final ValueChanged<String> onToast;

  @override
  Widget build(BuildContext context) {
    final pageTitle = selectedNav == 0 ? 'BUSINESS OVERVIEW' : navEntries[selectedNav].label;
    final dateStr = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()).toUpperCase();
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 560;
        final heading = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateStr,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.05,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              pageTitle,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 31,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.8,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'HERE’S WHAT’S HAPPENING WITH BALAMURUGAN ENTERPRISES TODAY.',
              style: TextStyle(color: AppColors.muted, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        );
        final actions = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!narrow)
              OutlinedButton.icon(
                onPressed: onImport,
                icon: const Icon(Icons.file_upload_outlined, size: 15),
                label: const Text('IMPORT'),
                style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ),
            if (!narrow) const SizedBox(width: 9),
            FilledButton.icon(
              onPressed: onCreateInvoice,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('CREATE INVOICE'),
              style: FilledButton.styleFrom(
                elevation: 2,
                shadowColor: AppColors.primary.withValues(alpha: .25),
                textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'MORE CREATE OPTIONS',
              onSelected: (value) {
                if (value == 'invoice') {
                  onCreateInvoice();
                } else if (value == 'bill') {
                  onToast('BILL WORKSPACE OPENED');
                } else {
                  onToast('EXPENSE WORKSPACE OPENED');
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'invoice',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.description_outlined, size: 17),
                    title: Text('NEW INVOICE', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                PopupMenuItem(
                  value: 'bill',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.receipt_long_outlined, size: 17),
                    title: Text('RECORD A BILL', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                PopupMenuItem(
                  value: 'expense',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.request_quote_outlined, size: 17),
                    title: Text('LOG AN EXPENSE', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
              child: Container(
                height: 40,
                width: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        );

        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [heading, const SizedBox(height: 18), actions],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Expanded(child: heading), actions],
        );
      },
    );
  }
}
