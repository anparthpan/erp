import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/company_profile.dart';
import 'package:balamurugan_erp/screens/getting_started/widgets/company_profile_dialog.dart';

class GettingStartedScreen extends StatefulWidget {
  final bool compact;
  final CompanyProfile companyProfile;
  final Function(CompanyProfile) onUpdateCompany;

  const GettingStartedScreen({
    super.key,
    required this.compact,
    required this.companyProfile,
    required this.onUpdateCompany,
  });

  @override
  State<GettingStartedScreen> createState() => _GettingStartedScreenState();
}

class _DashboardStep {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final IconData icon;
  final VoidCallback onAction;

  _DashboardStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.icon,
    required this.onAction,
  });
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  Future<void> _editCompanyProfile() async {
    final result = await showDialog<CompanyProfile>(
      context: context,
      builder: (context) => CompanyProfileDialog(currentProfile: widget.companyProfile),
    );

    if (result != null) {
      widget.onUpdateCompany(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      _DashboardStep(
        title: 'COMPANY PROFILE',
        subtitle: 'ADD YOUR BUSINESS NAME, LOGO, AND ADDRESS.',
        isCompleted: true,
        icon: Icons.business_outlined,
        onAction: _editCompanyProfile,
      ),
      _DashboardStep(
        title: 'BANK ACCOUNT',
        subtitle: 'CONNECT YOUR BANK ACCOUNT TO SYNC TRANSACTIONS.',
        isCompleted: true,
        icon: Icons.account_balance_outlined,
        onAction: () {},
      ),
      _DashboardStep(
        title: 'TAX DETAILS',
        subtitle: 'CONFIGURE YOUR GST/VAT SETTINGS.',
        isCompleted: false,
        icon: Icons.gavel_outlined,
        onAction: () {},
      ),
      _DashboardStep(
        title: 'CREATE FIRST INVOICE',
        subtitle: 'START GETTING PAID BY SENDING YOUR FIRST INVOICE.',
        isCompleted: false,
        icon: Icons.description_outlined,
        onAction: () {},
      ),
      _DashboardStep(
        title: 'INVITE TEAM',
        subtitle: 'BRING YOUR ACCOUNTANT AND COLLEAGUES ON BOARD.',
        isCompleted: false,
        icon: Icons.person_add_outlined,
        onAction: () {},
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GETTING STARTED',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: AppColors.ink,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'COMPLETE THESE STEPS TO GET YOUR BUSINESS UP AND RUNNING.',
          style: TextStyle(color: AppColors.muted, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        Column(
          children: steps.map((step) => _buildStepRow(step, step == steps.last)).toList(),
        ),
      ],
    );
  }

  Widget _buildStepRow(_DashboardStep step, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: step.isCompleted ? AppColors.green : AppColors.line,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  step.isCompleted ? Icons.check : step.icon,
                  color: step.isCompleted ? Colors.white : AppColors.muted,
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.line,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step.subtitle,
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: step.onAction,
                        child: Text(step.isCompleted ? 'EDIT' : 'START', style: const TextStyle(fontWeight: FontWeight.w900)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
