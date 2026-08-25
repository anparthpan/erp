import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';

class InvoicesScreen extends StatefulWidget {
  final bool compact;
  final List<TransactionItem> invoices;
  final VoidCallback onCreateInvoice;
  final Function(TransactionItem) onEditInvoice;
  final Function(TransactionItem) onDeleteInvoice;
  final Function(TransactionItem) onPrintInvoice;
  final Function(TransactionItem) onMarkPaid;

  const InvoicesScreen({
    super.key,
    required this.compact,
    required this.invoices,
    required this.onCreateInvoice,
    required this.onEditInvoice,
    required this.onDeleteInvoice,
    required this.onPrintInvoice,
    required this.onMarkPaid,
  });

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  String filter = 'ALL';
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredInvoices = widget.invoices.where((t) {
      final matchesFilter = filter == 'ALL' || t.status.toUpperCase() == filter;
      final matchesSearch = t.party.toLowerCase().contains(searchController.text.toLowerCase()) ||
          t.id.toLowerCase().contains(searchController.text.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'INVOICES',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: widget.onCreateInvoice,
              icon: const Icon(Icons.add),
              label: const Text('NEW INVOICE'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextField(
          controller: searchController,
          onChanged: (v) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'SEARCH INVOICES BY CUSTOMER OR ID...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        _buildFilters(),
        const SizedBox(height: 24),
        _buildInvoiceList(filteredInvoices),
      ],
    );
  }

  Widget _buildFilters() {
    final filters = ['ALL', 'DRAFT', 'PENDING', 'PAID', 'OVERDUE'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isSelected = filter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(f),
              selected: isSelected,
              onSelected: (val) => setState(() => filter = f),
              selectedColor: AppColors.primarySoft,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.muted,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.line,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInvoiceList(List<TransactionItem> invoices) {
    if (invoices.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text('NO INVOICES FOUND.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold)),
        ),
      );
    }
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.line),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: invoices.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.line),
        itemBuilder: (context, index) {
          final item = invoices[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color),
            ),
            title: Text(
              item.party.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink),
            ),
            subtitle: Text('${item.id} • ${item.date}'.toUpperCase()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.amount,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppColors.ink,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(item.status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(item.status),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      widget.onEditInvoice(item);
                    } else if (value == 'delete') {
                      widget.onDeleteInvoice(item);
                    } else if (value == 'print') {
                      widget.onPrintInvoice(item);
                    } else if (value == 'paid') {
                      widget.onMarkPaid(item);
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
                      value: 'print',
                      child: ListTile(
                        leading: Icon(Icons.print_outlined),
                        title: Text('PRINT'),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      ),
                    ),
                    if (item.status.toUpperCase() != 'PAID')
                      const PopupMenuItem(
                        value: 'paid',
                        child: ListTile(
                          leading: Icon(Icons.check_circle_outline, color: AppColors.green),
                          title: Text('MARK AS PAID'),
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
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PAID': return AppColors.green;
      case 'PENDING': return AppColors.amber;
      case 'OVERDUE': return AppColors.red;
      default: return AppColors.muted;
    }
  }
}
