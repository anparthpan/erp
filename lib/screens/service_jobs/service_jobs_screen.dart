import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/service_job.dart';
import 'package:intl/intl.dart';

class ServiceJobsScreen extends StatelessWidget {
  final List<ServiceJob> jobs;
  final VoidCallback onCreateJob;
  final Function(ServiceJob) onEditJob;
  final Function(ServiceJob) onDeleteJob;
  final Function(ServiceJob) onMarkPaid;

  const ServiceJobsScreen({
    super.key,
    required this.jobs,
    required this.onCreateJob,
    required this.onEditJob,
    required this.onDeleteJob,
    required this.onMarkPaid,
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
              'SERVICE JOBS',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreateJob,
              icon: const Icon(Icons.add),
              label: const Text('NEW SERVICE JOB'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.line),
          ),
          child: Column(
            children: jobs.map<Widget>((job) {
              final isLast = jobs.indexOf(job) == jobs.length - 1;
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.build_circle_outlined, color: AppColors.primary),
                    ),
                    title: Row(
                      children: [
                        Text(job.customerName, style: const TextStyle(fontWeight: FontWeight.w900)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(4)),
                          child: Text(job.vehicleNo, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('${job.id} • ${DateFormat('dd MMM yyyy').format(job.date)}'),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₹${NumberFormat("#,##,##0.00", "en_IN").format(job.total)}',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: job.status == 'Paid' ? AppColors.greenSoft : AppColors.amberSoft,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                job.status.toUpperCase(),
                                style: TextStyle(
                                  color: job.status == 'Paid' ? AppColors.green : AppColors.amber,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'edit') onEditJob(job);
                            if (value == 'delete') onDeleteJob(job);
                            if (value == 'paid') onMarkPaid(job);
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'edit', child: Text('EDIT')),
                            if (job.status != 'Paid')
                              const PopupMenuItem(value: 'paid', child: Text('MARK AS PAID')),
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
