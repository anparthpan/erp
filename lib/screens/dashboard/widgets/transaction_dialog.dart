import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionDialog extends StatefulWidget {
  final TransactionItem? transaction;
  final String category; // 'purchases', 'expenses', 'banking'

  const TransactionDialog({super.key, this.transaction, required this.category});

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController partyController;
  late TextEditingController amountController;
  late String type;
  late IconData icon;
  late Color color;
  late Color background;

  @override
  void initState() {
    super.initState();
    partyController = TextEditingController(text: widget.transaction?.party ?? '');
    amountController = TextEditingController(text: widget.transaction?.amount.replaceAll(RegExp(r'[^0-9.]'), '') ?? '');
    
    if (widget.category == 'purchases') {
      type = 'Vendor bill';
      icon = Icons.receipt_long_outlined;
      color = AppColors.purple;
      background = AppColors.purpleSoft;
    } else if (widget.category == 'expenses') {
      type = 'Business expense';
      icon = Icons.request_quote_outlined;
      color = AppColors.amber;
      background = AppColors.amberSoft;
    } else {
      type = 'Bank transaction';
      icon = Icons.account_balance_wallet_outlined;
      color = AppColors.green;
      background = AppColors.greenSoft;
    }
  }

  @override
  void dispose() {
    partyController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titlePrefix = widget.transaction == null ? 'Add' : 'Edit';
    String titleLabel = widget.category == 'purchases' ? 'Bill' : (widget.category == 'expenses' ? 'Expense' : 'Transaction');

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
                '$titlePrefix $titleLabel',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: partyController,
                decoration: InputDecoration(
                  labelText: widget.category == 'purchases' ? 'Vendor Name' : 'Party / Description',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '₹ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => double.tryParse(value!) == null ? 'Enter valid amount' : null,
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
                        final formatter = NumberFormat("#,##,##0", "en_IN");
                        final amountVal = double.parse(amountController.text);
                        
                        Navigator.pop(
                          context,
                          (widget.transaction ?? TransactionItem(
                            id: '${widget.category == 'purchases' ? 'BILL' : 'EXP'}-${1000 + DateTime.now().millisecond}',
                            type: type,
                            party: partyController.text,
                            date: DateFormat('dd MMM yyyy').format(DateTime.now()),
                            amount: '₹${formatter.format(amountVal)}',
                            status: 'Pending',
                            category: widget.category,
                            icon: icon,
                            color: color,
                            background: background,
                          )).copyWith(
                            party: partyController.text,
                            amount: '₹${formatter.format(amountVal)}',
                          ),
                        );
                      }
                    },
                    child: Text(widget.transaction == null ? 'Add' : 'Save'),
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
