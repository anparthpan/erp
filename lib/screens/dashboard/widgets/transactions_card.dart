import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';

class TransactionsCard extends StatelessWidget {
  final List<TransactionItem> transactions;
  final String searchQuery;
  final String activeFilter;
  final ValueChanged<String> onFilterChanged;
  final VoidCallback onExport;
  final VoidCallback onFilter;

  const TransactionsCard({
    super.key,
    required this.transactions,
    required this.searchQuery,
    required this.activeFilter,
    required this.onFilterChanged,
    required this.onExport,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    final query = searchQuery.trim().toLowerCase();
    final visibleItems = transactions.where((item) {
      final categoryMatches = activeFilter == 'all' || item.category == activeFilter;
      final textMatches = query.isEmpty ||
          '${item.id} ${item.type} ${item.party} ${item.status}'
              .toLowerCase()
              .contains(query);
      return categoryMatches && textMatches;
    }).toList();

    const tabs = [
      ('all', 'ALL ACTIVITY'),
      ('sales', 'SALES'),
      ('purchases', 'PURCHASES'),
      ('expenses', 'EXPENSES'),
      ('banking', 'BANKING'),
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(21, 19, 21, 14),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RECENT TRANSACTIONS',
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'A CLEAR VIEW OF YOUR LATEST ACTIVITY',
                        style: TextStyle(color: AppColors.muted, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: onExport,
                  icon: const Icon(Icons.download_outlined, size: 15),
                  label: const Text('EXPORT', style: TextStyle(fontWeight: FontWeight.w900)),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onFilter,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(38, 38),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.tune_rounded, size: 16),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Row(
              children: tabs
                  .map(
                    (tab) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: TextButton(
                        onPressed: () => onFilterChanged(tab.$1),
                        style: TextButton.styleFrom(
                          foregroundColor: activeFilter == tab.$1
                              ? AppColors.primary
                              : const Color(0xFF8490A4),
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                              color: activeFilter == tab.$1
                                  ? AppColors.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          tab.$2,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.line),
          if (visibleItems.isEmpty)
            const Padding(
              padding: EdgeInsets.all(34),
              child: Center(
                child: Text(
                  'NO TRANSACTIONS MATCH YOUR SEARCH.',
                  style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 40,
                dataRowMinHeight: 58,
                dataRowMaxHeight: 68,
                horizontalMargin: 21,
                columnSpacing: 38,
                headingTextStyle: const TextStyle(
                  color: Color(0xFF99A4B5),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .8,
                ),
                dataTextStyle: const TextStyle(
                  color: Color(0xFF58667D),
                  fontSize: 11,
                ),
                columns: const [
                  DataColumn(label: Text('TRANSACTION')),
                  DataColumn(label: Text('PARTY')),
                  DataColumn(label: Text('DATE')),
                  DataColumn(label: Text('AMOUNT')),
                  DataColumn(label: Text('STATUS')),
                ],
                rows: visibleItems.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 178,
                          child: Row(
                            children: [
                              Container(
                                width: 27,
                                height: 27,
                                decoration: BoxDecoration(
                                  color: item.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(item.icon, color: item.color, size: 14),
                              ),
                              const SizedBox(width: 9),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.id.toUpperCase(),
                                      style: const TextStyle(
                                        color: Color(0xFF283750),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      item.type.toUpperCase(),
                                      style: const TextStyle(
                                        color: Color(0xFFA2ADBD),
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 145,
                          child: Text(
                            item.party.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      DataCell(Text(item.date.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(
                        Text(
                          item.amount,
                          style: TextStyle(
                            color: item.positive
                                ? AppColors.green
                                : const Color(0xFF263751),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      DataCell(StatusPill(status: item.status.toUpperCase())),
                    ],
                  );
                }).toList(),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 13),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF0F2F5))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  visibleItems.isEmpty
                      ? '0 TRANSACTIONS FOUND'
                      : 'SHOWING 1–${visibleItems.length} OF 24 TRANSACTIONS',
                  style: const TextStyle(color: AppColors.muted, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    _PageButton(label: '1', active: true, onTap: () {}),
                    _PageButton(label: '2', onTap: () => onFilterChanged(activeFilter)),
                    _PageButton(label: '3', onTap: () => onFilterChanged(activeFilter)),
                    _PageButton(label: '→', onTap: () => onFilterChanged(activeFilter)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final Color color;
    final Color background;
    switch (status.toUpperCase()) {
      case 'OVERDUE':
        color = AppColors.red;
        background = AppColors.redSoft;
        break;
      case 'PENDING':
        color = AppColors.amber;
        background = AppColors.amberSoft;
        break;
      case 'DRAFT':
        color = const Color(0xFF78869D);
        background = const Color(0xFFF0F2F5);
        break;
      default:
        color = AppColors.green;
        background = AppColors.greenSoft;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: SizedBox(
        width: 25,
        height: 25,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            foregroundColor: active ? AppColors.primary : const Color(0xFF8995A9),
            backgroundColor: active ? AppColors.primarySoft : Colors.white,
            side: BorderSide(
              color: active ? const Color(0xFFBDD0FF) : AppColors.line,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
