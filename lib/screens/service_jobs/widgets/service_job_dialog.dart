import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/service_job.dart';
import 'package:balamurugan_erp/models/invoice_item.dart';
import 'package:balamurugan_erp/models/customer.dart';
import 'package:intl/intl.dart';

class ServiceJobDialog extends StatefulWidget {
  final ServiceJob? job;
  final List<Customer> customers;

  const ServiceJobDialog({super.key, this.job, required this.customers});

  @override
  State<ServiceJobDialog> createState() => _ServiceJobDialogState();
}

class _ServiceJobDialogState extends State<ServiceJobDialog> {
  final _formKey = GlobalKey<FormState>();
  late String? customerName;
  late TextEditingController vehicleNoController;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  bool applyGst = false;
  List<InvoiceItem> items = [];

  @override
  void initState() {
    super.initState();
    customerName = widget.job?.customerName;
    vehicleNoController = TextEditingController(text: widget.job?.vehicleNo ?? '');
    mobileController = TextEditingController(text: widget.job?.mobile ?? '');
    addressController = TextEditingController(text: widget.job?.address ?? '');
    applyGst = widget.job?.applyGst ?? false;
    items = widget.job != null ? List.from(widget.job!.items) : [];
    if (items.isEmpty) _addNewItem();
  }

  void _addNewItem() {
    setState(() {
      items.add(InvoiceItem(
        description: '',
        subDescription: '',
        quantity: 1,
        unit: 'Piece',
        rate: 0,
      ));
    });
  }

  double get totalAmount => items.fold<double>(0.0, (sum, item) => sum + item.amount) * (applyGst ? 1.18 : 1);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.job == null ? 'CREATE NEW SERVICE JOB' : 'EDIT SERVICE JOB',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                DropdownButtonFormField<String>(
                  initialValue: customerName,
                  decoration: const InputDecoration(labelText: 'CUSTOMER *'),
                        items: widget.customers.map((c) => DropdownMenuItem(value: c.name, child: Text(c.name.toUpperCase()))).toList(),
                        onChanged: (v) {
                          setState(() {
                            customerName = v;
                            final customer = widget.customers.firstWhere((c) => c.name == v);
                            mobileController.text = customer.mobile;
                            addressController.text = customer.address;
                          });
                        },
                        validator: (v) => v == null ? 'REQUIRED' : null,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: vehicleNoController,
                              decoration: const InputDecoration(labelText: 'VEHICLE / DEVICE NO *'),
                              validator: (v) => v!.isEmpty ? 'REQUIRED' : null,
                              textCapitalization: TextCapitalization.characters,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: mobileController,
                              decoration: const InputDecoration(labelText: 'MOBILE NO'),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(labelText: 'ADDRESS'),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 24),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('SERVICE ITEMS', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.muted, fontSize: 11, letterSpacing: 1)),
                      ),
                      const SizedBox(height: 12),
                      ...items.asMap().entries.map((e) => _buildItemRow(e.key)),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: _addNewItem,
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('ADD SERVICE ITEM', style: TextStyle(fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('APPLY GST (18%)', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      Switch(value: applyGst, onChanged: (v) => setState(() => applyGst = v)),
                    ],
                  ),
                  Text(
                    'TOTAL: ₹${NumberFormat("#,##,##0.00", "en_IN").format(totalAmount)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.ink),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL', style: TextStyle(fontWeight: FontWeight.w900))),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          ServiceJob(
                            id: widget.job?.id ?? 'JOB-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                            customerName: customerName!,
                            vehicleNo: vehicleNoController.text,
                            mobile: mobileController.text,
                            address: addressController.text,
                            date: widget.job?.date ?? DateTime.now(),
                            items: items,
                            status: widget.job?.status ?? 'Pending',
                            applyGst: applyGst,
                          ),
                        );
                      }
                    },
                    child: Text(widget.job == null ? 'CREATE JOB' : 'SAVE CHANGES', style: const TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(int index) {
    final item = items[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              initialValue: item.description,
              decoration: const InputDecoration(labelText: 'DESCRIPTION', hintText: 'E.G. OIL CHANGE'),
              textCapitalization: TextCapitalization.characters,
              onChanged: (v) => items[index] = item.copyWith(description: v),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              initialValue: item.quantity.toString(),
              decoration: const InputDecoration(labelText: 'QTY'),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => items[index] = item.copyWith(quantity: double.tryParse(v) ?? 1)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextFormField(
              initialValue: item.rate.toString(),
              decoration: const InputDecoration(labelText: 'RATE', prefixText: '₹'),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => items[index] = item.copyWith(rate: double.tryParse(v) ?? 0)),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => items.removeAt(index)),
            icon: const Icon(Icons.delete_outline, color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
