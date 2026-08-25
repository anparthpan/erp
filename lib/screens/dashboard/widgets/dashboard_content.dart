import 'package:flutter/material.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/page_heading.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/stats_grid.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/income_expense_card.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/tasks_card.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/automation_strip.dart';
import 'package:balamurugan_erp/screens/dashboard/widgets/transactions_card.dart';

import '../../../models/transaction_item.dart';

class DashboardContent extends StatelessWidget {
  final bool compact;
  final List<TransactionItem> transactions;
  final String searchQuery;
  final int selectedNav;
  final String transactionFilter;
  final String chartRange;
  final VoidCallback onCreateInvoice;
  final VoidCallback onImport;
  final ValueChanged<String> onToast;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onChartRangeChanged;
  final VoidCallback onExport;
  final VoidCallback onFilter;

  const DashboardContent({
    super.key,
    required this.compact,
    required this.transactions,
    required this.searchQuery,
    required this.selectedNav,
    required this.transactionFilter,
    required this.chartRange,
    required this.onCreateInvoice,
    required this.onImport,
    required this.onToast,
    required this.onFilterChanged,
    required this.onChartRangeChanged,
    required this.onExport,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeading(
              selectedNav: selectedNav,
              onCreateInvoice: onCreateInvoice,
              onImport: onImport,
              onToast: onToast,
            ),
            const SizedBox(height: 27),
            const StatsGrid(),
            const SizedBox(height: 19),
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 980;
                if (stacked) {
                  return Column(
                    children: [
                      IncomeExpenseCard(
                        chartRange: chartRange,
                        onRangeChanged: onChartRangeChanged,
                      ),
                      const SizedBox(height: 19),
                      const TasksCard(),
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 16,
                      child: IncomeExpenseCard(
                        chartRange: chartRange,
                        onRangeChanged: onChartRangeChanged,
                      ),
                    ),
                    const SizedBox(width: 19),
                    const Expanded(flex: 9, child: TasksCard()),
                  ],
                );
              },
            ),
            const SizedBox(height: 19),
            AutomationStrip(onToast: onToast),
            const SizedBox(height: 19),
            TransactionsCard(
              transactions: transactions,
              searchQuery: searchQuery,
              activeFilter: transactionFilter,
              onFilterChanged: onFilterChanged,
              onExport: onExport,
              onFilter: onFilter,
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
