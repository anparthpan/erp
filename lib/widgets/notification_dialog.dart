import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key, required this.onMarkRead});

  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(20, 18, 14, 8),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      title: Row(
        children: [
          const Expanded(
            child: Text(
              'Notifications',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          TextButton(
            onPressed: onMarkRead,
            child: const Text(
              'Mark all read',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      content: const SizedBox(
        width: 310,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NotificationItem(
              title: 'Bank feed needs attention',
              detail: '2 transactions are ready to match.',
              time: '18 min ago',
              icon: Icons.account_balance_outlined,
            ),
            NotificationItem(
              title: 'Payment received',
              detail: '₹42,500 from Northstar Labs.',
              time: '1 hr ago',
              icon: Icons.description_outlined,
            ),
            NotificationItem(
              title: 'GST return reminder',
              detail: 'GSTR-3B is due in 6 days.',
              time: 'Yesterday',
              icon: Icons.calendar_today_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.title,
    required this.detail,
    required this.time,
    required this.icon,
  });

  final String title;
  final String detail;
  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F3F6))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary, size: 14),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF2C3B55),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 10,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: const TextStyle(color: Color(0xFFA1ABBB), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
