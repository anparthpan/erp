import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/project.dart';

class ProjectsScreen extends StatelessWidget {
  final bool compact;
  final List<Project> projects;
  final VoidCallback onCreate;
  final Function(Project) onEdit;
  final Function(Project) onDelete;

  const ProjectsScreen({
    super.key,
    required this.compact,
    required this.projects,
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
              'PROJECTS & TIME',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add_task),
              label: const Text('NEW PROJECT'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        projects.isEmpty
            ? const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('NO PROJECTS FOUND.', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold))))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  final double progress = project.progress;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.line),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(project.name.toUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                                    Text(project.client.toUpperCase(), style: const TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(project.status).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      project.status.toUpperCase(),
                                      style: TextStyle(
                                        color: _getStatusColor(project.status),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  PopupMenuButton<String>(
                                    onSelected: (v) {
                                      if (v == 'edit') onEdit(project);
                                      if (v == 'delete') onDelete(project);
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(value: 'edit', child: Text('EDIT')),
                                      const PopupMenuItem(value: 'delete', child: Text('DELETE', style: TextStyle(color: AppColors.red))),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: AppColors.line,
                                  color: progress == 1.0 ? AppColors.green : AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text('${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed': return AppColors.green;
      case 'in progress': return AppColors.primary;
      case 'on hold': return AppColors.amber;
      default: return AppColors.muted;
    }
  }
}
