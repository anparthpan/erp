import 'package:flutter/material.dart';
import 'package:balamurugan_erp/models/customer.dart';

class CustomerDialog extends StatefulWidget {
  final Customer? customer;

  const CustomerDialog({super.key, this.customer});

  @override
  State<CustomerDialog> createState() => _CustomerDialogState();
}

class _CustomerDialogState extends State<CustomerDialog> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController addressController;
  late TextEditingController gstController;
  late TextEditingController balanceController;
  String status = 'Active';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.customer?.name ?? '');
    emailController = TextEditingController(text: widget.customer?.email ?? '');
    mobileController = TextEditingController(text: widget.customer?.mobile ?? '');
    addressController = TextEditingController(text: widget.customer?.address ?? '');
    gstController = TextEditingController(text: widget.customer?.gstNumber ?? '');
    balanceController = TextEditingController(text: widget.customer?.balance ?? '₹0');
    status = widget.customer?.status ?? 'Active';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    gstController.dispose();
    balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.customer == null ? 'Add New Customer' : 'Edit Customer',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Customer Name *', border: OutlineInputBorder()),
                  validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email Address', border: OutlineInputBorder()),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: mobileController,
                        decoration: const InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder()),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: gstController,
                        decoration: const InputDecoration(labelText: 'GST Number', border: OutlineInputBorder()),
                        textCapitalization: TextCapitalization.characters,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: balanceController,
                        decoration: const InputDecoration(labelText: 'Opening Balance', border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: status,
                  decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
                  items: ['Active', 'Inactive', 'Overdue']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) => setState(() => status = value!),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(
                            context,
                            Customer(
                              name: nameController.text,
                              email: emailController.text,
                              mobile: mobileController.text,
                              address: addressController.text,
                              gstNumber: gstController.text,
                              balance: balanceController.text,
                              status: status,
                            ),
                          );
                        }
                      },
                      child: Text(widget.customer == null ? 'Add' : 'Save'),
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
}
