import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/customer.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';
import 'package:balamurugan_erp/models/invoice_item.dart';
import 'package:intl/intl.dart';

class InvoiceDialog extends StatefulWidget {
  final TransactionItem? invoice;
  final List<Customer> customers;

  const InvoiceDialog({super.key, this.invoice, required this.customers});

  @override
  State<InvoiceDialog> createState() => _InvoiceDialogState();
}

class _InvoiceDialogState extends State<InvoiceDialog> {
  final formKey = GlobalKey<FormState>();
  String? customer;
  String dueDate = 'Net 15';
  String currency = 'INR — Indian Rupee';
  bool applyTax = true;
  List<InvoiceItem> items = [];

  @override
  void initState() {
    super.initState();
    if (widget.invoice != null) {
      customer = widget.invoice!.party;
      applyTax = widget.invoice!.applyGst;
      items = List.from(widget.invoice!.items ?? []);
    }
    if (items.isEmpty) {
      _addNewItem();
    }
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

  void _removeItem(int index) {
    setState(() {
      if (items.length > 1) {
        items.removeAt(index);
      }
    });
  }

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 850, maxHeight: 900),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 21),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.invoice == null ? 'Create new invoice' : 'Edit invoice',
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.25,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Enter your invoice details and line items below.',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F7FA),
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 17),
                    ),
                  ],
                ),
                const SizedBox(height: 21),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        initialValue: customer,
                        decoration: const InputDecoration(
                          labelText: 'Customer *',
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                        hint: const Text(
                          'Select a customer',
                          style: TextStyle(fontSize: 12),
                        ),
                        items: widget.customers.map((c) {
                          return DropdownMenuItem(value: c.name, child: Text(c.name));
                        }).toList(),
                        validator: (value) => value == null ? 'Select a customer' : null,
                        onChanged: (value) => setState(() => customer = value),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextFormField(
                        initialValue: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        decoration: const InputDecoration(
                          labelText: 'Invoice date',
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: dueDate,
                        decoration: const InputDecoration(
                          labelText: 'Payment due',
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Due on receipt', child: Text('Due on receipt')),
                          DropdownMenuItem(value: 'Net 15', child: Text('Net 15')),
                          DropdownMenuItem(value: 'Net 30', child: Text('Net 30')),
                          DropdownMenuItem(value: 'Net 45', child: Text('Net 45')),
                        ],
                        onChanged: (value) => setState(() => dueDate = value ?? 'Net 15'),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: currency,
                        decoration: const InputDecoration(
                          labelText: 'Currency',
                          labelStyle: TextStyle(fontSize: 12),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'INR — Indian Rupee', child: Text('INR — Indian Rupee')),
                          DropdownMenuItem(value: 'USD — US Dollar', child: Text('USD — US Dollar')),
                          DropdownMenuItem(value: 'EUR — Euro', child: Text('EUR — Euro')),
                        ],
                        onChanged: (value) => setState(() => currency = value ?? currency),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'LINE ITEMS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...items.asMap().entries.map((entry) {
                          final index = entry.key;
                          return _buildItemRow(index);
                        }),
                        const SizedBox(height: 16),
                        TextButton.icon(
                          onPressed: _addNewItem,
                          icon: const Icon(Icons.add_circle_outline, size: 18),
                          label: const Text('Add another item'),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 32, color: AppColors.line),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Apply GST (18%)',
                                style: TextStyle(
                                  color: Color(0xFF52617A),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Switch.adaptive(
                                value: applyTax,
                                activeTrackColor: AppColors.primary,
                                onChanged: (value) => setState(() => applyTax = value),
                              ),
                            ],
                          ),
                          const Text(
                            'HSN code fields will be shown when GST is applied.',
                            style: TextStyle(color: AppColors.muted, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Total: ₹${NumberFormat("#,##,##0.00", "en_IN").format(totalAmount * (applyTax ? 1.18 : 1))}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        if (applyTax)
                          Text(
                            'Incl. GST: ₹${NumberFormat("#,##,##0.00", "en_IN").format(totalAmount * 0.18)}',
                            style: const TextStyle(fontSize: 11, color: AppColors.green, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 9),
                    FilledButton.icon(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          final formatter = NumberFormat("#,##,##0", "en_IN");
                          final finalAmount = totalAmount * (applyTax ? 1.18 : 1);
                          
                          // Find selected customer object to get address
                          final selectedCustomer = widget.customers.firstWhere(
                            (c) => c.name == customer,
                          );

                          final result = (widget.invoice ?? TransactionItem(
                            id: 'INV-${1000 + DateTime.now().millisecond}',
                            type: 'Sales invoice',
                            party: customer!,
                            date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                            amount: '₹${formatter.format(finalAmount)}',
                            status: 'Pending',
                            category: 'sales',
                            icon: Icons.description_outlined,
                            color: AppColors.primary,
                            background: AppColors.primarySoft,
                          )).copyWith(
                            party: customer,
                            amount: '₹${formatter.format(finalAmount)}',
                            items: items,
                            applyGst: applyTax,
                            customerAddress: selectedCustomer.address,
                            customerGst: selectedCustomer.gstNumber,
                          );
                          
                          Navigator.pop(context, result);
                        }
                      },
                      icon: const Icon(Icons.send_outlined, size: 15),
                      label: const Text('Save & preview'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(int index) {
    final item = items[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: item.description,
                      decoration: const InputDecoration(
                        labelText: 'Item Name',
                        hintText: 'e.g. Dell XPS 15 Laptop',
                      ),
                      onChanged: (v) => setState(() {
                        items[index] = item.copyWith(description: v);
                      }),
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      initialValue: item.subDescription,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Full Configuration / Details',
                        hintText: 'Enter specifications, serial numbers, etc.',
                      ),
                      onChanged: (v) => setState(() {
                        items[index] = item.copyWith(subDescription: v);
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (applyTax)
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: item.hsnCode,
                    decoration: const InputDecoration(labelText: 'HSN/SAC'),
                    onChanged: (v) => setState(() {
                      items[index] = item.copyWith(hsnCode: v);
                    }),
                  ),
                ),
              if (applyTax) const SizedBox(width: 12),
              IconButton(
                onPressed: () => _removeItem(index),
                icon: const Icon(Icons.delete_outline, color: AppColors.red, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: item.quantity == 0 ? '' : item.quantity.toString(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Qty'),
                  onChanged: (v) => setState(() {
                    items[index] = item.copyWith(quantity: double.tryParse(v) ?? 0);
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue: item.unit,
                  decoration: const InputDecoration(
                    labelText: 'Unit',
                    hintText: 'Pcs',
                  ),
                  onChanged: (v) => setState(() {
                    items[index] = item.copyWith(unit: v);
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: TextFormField(
                  initialValue: item.rate == 0 ? '' : item.rate.toString(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Unit Price',
                    prefixText: '₹ ',
                  ),
                  onChanged: (v) => setState(() {
                    items[index] = item.copyWith(rate: double.tryParse(v.replaceAll(',', '')) ?? 0);
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Amount', style: TextStyle(fontSize: 10, color: AppColors.muted)),
                    Text(
                      '₹${NumberFormat("#,##,##0.00", "en_IN").format(item.amount)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
