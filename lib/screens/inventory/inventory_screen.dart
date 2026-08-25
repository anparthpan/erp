import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/inventory_item.dart';

class InventoryScreen extends StatelessWidget {
  final bool compact;
  final List<InventoryItem> inventory;
  final VoidCallback onCreate;
  final Function(InventoryItem) onEdit;
  final Function(InventoryItem) onDelete;

  const InventoryScreen({
    super.key,
    required this.compact,
    required this.inventory,
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
              'INVENTORY',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add_box_outlined),
              label: const Text('ADD ITEM'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        inventory.isEmpty
            ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('NO ITEMS IN INVENTORY.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold))))
            : Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: Column(
                  children: inventory.map<Widget>((item) {
                    final isLast = inventory.indexOf(item) == inventory.length - 1;
                    final int stock = item.stock;
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          title: Text(item.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.ink)),
                          subtitle: Text('SKU: ${item.sku}'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(item.price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text(
                                    stock == 0 ? 'OUT OF STOCK' : '$stock IN STOCK',
                                    style: TextStyle(
                                      color: stock == 0 ? AppColors.red : (stock < 10 ? AppColors.amber : AppColors.green),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
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
