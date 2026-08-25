import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';
import 'package:balamurugan_erp/models/service_job.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatelessWidget {
  final bool compact;
  final List<TransactionItem> transactions;
  final List<ServiceJob> serviceJobs;

  const ReportsScreen({
    super.key,
    required this.compact,
    required this.transactions,
    required this.serviceJobs,
  });

  double get invoiceSales => transactions.where((t) => t.category == 'sales').fold(0, (sum, t) => sum + _parseAmount(t.amount));
  double get serviceSales => serviceJobs.fold(0, (sum, j) => sum + j.total);
  double get totalRevenue => invoiceSales + serviceSales;
  
  double get expensesTotal => transactions.where((t) => t.category == 'expenses').fold(0, (sum, t) => sum + _parseAmount(t.amount));
  double get purchasesTotal => transactions.where((t) => t.category == 'purchases').fold(0, (sum, t) => sum + _parseAmount(t.amount));
  double get totalCosts => expensesTotal + purchasesTotal;
  
  double get netProfit => totalRevenue - totalCosts;

  double _parseAmount(String amount) {
    final clean = amount.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(clean) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'REPORTS',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: compact ? 1 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildReportCard(
              'PROFIT & LOSS',
              'NET PROFIT: ₹${NumberFormat("#,##,##0", "en_IN").format(netProfit)}',
              Icons.pie_chart_outline,
              () => _showProfitLossDialog(context),
            ),
            _buildReportCard(
              'SALES SUMMARY',
              'TOTAL REVENUE: ₹${NumberFormat("#,##,##0", "en_IN").format(totalRevenue)}',
              Icons.trending_up,
              () {},
            ),
            _buildReportCard(
              'EXPENSE SUMMARY',
              'TOTAL SPENDS: ₹${NumberFormat("#,##,##0", "en_IN").format(expensesTotal)}',
              Icons.request_quote_outlined,
              () {},
            ),
            _buildReportCard(
              'TAX SUMMARY',
              'GST LIABILITY REPORTS',
              Icons.account_balance_outlined,
              () {},
            ),
          ],
        ),
      ],
    );
  }

  void _showProfitLossDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('PROFIT & LOSS STATEMENT', style: TextStyle(fontWeight: FontWeight.w900)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _row('INVOICE SALES', invoiceSales, Colors.green),
            _row('SERVICE SALES', serviceSales, Colors.green),
            _row('TOTAL REVENUE', totalRevenue, Colors.green, isBold: true),
            const Divider(),
            _row('PURCHASES', purchasesTotal, Colors.red),
            _row('OPERATING EXPENSES', expensesTotal, Colors.orange),
            _row('TOTAL COSTS', totalCosts, Colors.red, isBold: true),
            const Divider(),
            _row('NET PROFIT', netProfit, netProfit >= 0 ? Colors.green : Colors.red, isBold: true),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE'))],
      ),
    );
  }

  Widget _row(String label, double val, Color color, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.w900 : FontWeight.bold, fontSize: 11)),
          Text(
            '₹${NumberFormat("#,##,##0.00", "en_IN").format(val)}',
            style: TextStyle(fontWeight: FontWeight.w900, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.line),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: AppColors.primary),
            ),
            const Spacer(),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13, fontWeight: FontWeight.w900)),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('VIEW REPORT', style: TextStyle(fontWeight: FontWeight.w900)),
              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
            ),
          ],
        ),
      ),
    );
  }
}
