import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/vendor.dart';

class VendorsScreen extends StatelessWidget {
  final bool compact;
  final List<Vendor> vendors;
  final VoidCallback onCreate;
  final Function(Vendor) onEdit;
  final Function(Vendor) onDelete;

  const VendorsScreen({
    super.key,
    required this.compact,
    required this.vendors,
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
              'VENDORS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.storefront_outlined),
              label: const Text('ADD VENDOR'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        vendors.isEmpty
            ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('NO VENDORS FOUND.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold))))
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: compact ? 1 : 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.5,
                ),
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  final vendor = vendors[index];
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.line),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: AppColors.purpleSoft,
                                child: Text(vendor.name[0].toUpperCase(), style: const TextStyle(color: AppColors.purple, fontWeight: FontWeight.bold, fontSize: 18)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      vendor.name.toUpperCase(),
                                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(vendor.type.toUpperCase(), style: const TextStyle(color: AppColors.muted, fontSize: 10, fontWeight: FontWeight.w900)),
                                    const SizedBox(height: 4),
                                    Text(vendor.contact.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, size: 20, color: AppColors.muted),
                            onSelected: (value) {
                              if (value == 'edit') {
                                onEdit(vendor);
                              } else if (value == 'delete') {
                                onDelete(vendor);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text('EDIT')),
                              const PopupMenuItem(value: 'delete', child: Text('DELETE', style: TextStyle(color: AppColors.red))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ],
    );
  }
}
