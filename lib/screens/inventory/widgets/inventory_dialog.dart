import 'package:flutter/material.dart';
import 'package:balamurugan_erp/models/inventory_item.dart';

class InventoryItemDialog extends StatefulWidget {
  final InventoryItem? item;

  const InventoryItemDialog({super.key, this.item});

  @override
  State<InventoryItemDialog> createState() => _InventoryItemDialogState();
}

class _InventoryItemDialogState extends State<InventoryItemDialog> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController skuController;
  late TextEditingController stockController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item?.name ?? '');
    skuController = TextEditingController(text: widget.item?.sku ?? '');
    stockController = TextEditingController(text: widget.item?.stock.toString() ?? '0');
    priceController = TextEditingController(text: widget.item?.price ?? '₹0');
  }

  @override
  void dispose() {
    nameController.dispose();
    skuController.dispose();
    stockController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item == null ? 'Add New Item' : 'Edit Item',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: skuController,
                decoration: const InputDecoration(labelText: 'SKU', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter SKU' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: stockController,
                      decoration: const InputDecoration(labelText: 'Stock Qty', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) => int.tryParse(value!) == null ? 'Enter number' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price', border: OutlineInputBorder()),
                      validator: (value) => value!.isEmpty ? 'Enter price' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          InventoryItem(
                            name: nameController.text,
                            sku: skuController.text,
                            stock: int.parse(stockController.text),
                            price: priceController.text,
                          ),
                        );
                      }
                    },
                    child: Text(widget.item == null ? 'Add' : 'Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
