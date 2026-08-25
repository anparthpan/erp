import 'package:flutter/material.dart';
import 'package:balamurugan_erp/models/project.dart';
import 'package:balamurugan_erp/models/customer.dart';

class ProjectDialog extends StatefulWidget {
  final Project? project;
  final List<Customer> customers;

  const ProjectDialog({super.key, this.project, required this.customers});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  String? client;
  double progress = 0;
  String status = 'In Progress';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.project?.name ?? '');
    client = widget.project?.client;
    progress = widget.project?.progress ?? 0;
    status = widget.project?.status ?? 'In Progress';
  }

  @override
  void dispose() {
    nameController.dispose();
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
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project == null ? 'CREATE NEW PROJECT' : 'EDIT PROJECT',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'PROJECT NAME *'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: client,
                decoration: const InputDecoration(labelText: 'CLIENT *'),
                items: widget.customers.map((c) => DropdownMenuItem(value: c.name, child: Text(c.name))).toList(),
                onChanged: (v) => setState(() => client = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Text('PROGRESS: ${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Slider(
                value: progress,
                onChanged: (v) => setState(() => progress = v),
                divisions: 20,
                label: '${(progress * 100).toInt()}%',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(labelText: 'STATUS'),
                items: ['In Progress', 'Completed', 'On Hold', 'Cancelled']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s.toUpperCase())))
                    .toList(),
                onChanged: (v) => setState(() => status = v!),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          Project(
                            id: widget.project?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                            name: nameController.text,
                            client: client!,
                            progress: progress,
                            status: status,
                          ),
                        );
                      }
                    },
                    child: Text(widget.project == null ? 'CREATE' : 'SAVE'),
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
