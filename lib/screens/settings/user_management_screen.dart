import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/user_model.dart';

class UserManagementScreen extends StatelessWidget {
  final List<UserModel> users;
  final VoidCallback onCreateUser;
  final Function(UserModel) onResetPassword;
  final Function(UserModel) onDeleteUser;

  const UserManagementScreen({
    super.key,
    required this.users,
    required this.onCreateUser,
    required this.onResetPassword,
    required this.onDeleteUser,
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
              'USER MANAGEMENT',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.ink,
                letterSpacing: 0.5,
              ),
            ),
            FilledButton.icon(
              onPressed: onCreateUser,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: const Text('ADD NEW USER'),
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
            children: users.map<Widget>((user) {
              final isLast = users.indexOf(user) == users.length - 1;
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: user.isAdmin ? AppColors.primarySoft : AppColors.line,
                      child: Icon(
                        user.isAdmin ? Icons.admin_panel_settings_outlined : Icons.person_outline,
                        color: user.isAdmin ? AppColors.primary : AppColors.muted,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          user.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        if (user.isAdmin) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ADMIN',
                              style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Text(user.email.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!user.isAdmin)
                          IconButton(
                            icon: const Icon(Icons.lock_reset_outlined, size: 20),
                            tooltip: 'RESET PASSWORD',
                            onPressed: () => onResetPassword(user),
                          ),
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'delete') onDeleteUser(user);
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('DELETE USER', style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold)),
                            ),
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
