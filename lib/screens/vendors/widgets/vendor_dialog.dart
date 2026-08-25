import 'package:flutter/material.dart';
import 'package:balamurugan_erp/models/vendor.dart';

class VendorDialog extends StatefulWidget {
  final Vendor? vendor;

  const VendorDialog({super.key, this.vendor});

  @override
  State<VendorDialog> createState() => _VendorDialogState();
}

class _VendorDialogState extends State<VendorDialog> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.vendor?.name ?? '');
    typeController = TextEditingController(text: widget.vendor?.type ?? '');
    contactController = TextEditingController(text: widget.vendor?.contact ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    typeController.dispose();
    contactController.dispose();
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
                widget.vendor == null ? 'Add New Vendor' : 'Edit Vendor',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Company Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(labelText: 'Business Type', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter a type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(labelText: 'Contact / Email', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter contact info' : null,
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
                          Vendor(
                            name: nameController.text,
                            type: typeController.text,
                            contact: contactController.text,
                          ),
                        );
                      }
                    },
                    child: Text(widget.vendor == null ? 'Add' : 'Save'),
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
