import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/user_model.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.compact,
    required this.hasUnread,
    required this.controller,
    required this.onMenu,
    required this.onSearch,
    required this.onNotifications,
    required this.user,
  });

  final bool compact;
  final bool hasUnread;
  final TextEditingController controller;
  final VoidCallback onMenu;
  final ValueChanged<String> onSearch;
  final VoidCallback onNotifications;
  final UserModel user;

  String get initials {
    if (user.name.isEmpty) return '??';
    final parts = user.name.split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 64 : 72,
      padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 34),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .93),
        border: const Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          if (compact)
            IconButton(
              onPressed: onMenu,
              tooltip: 'Open navigation',
              icon: const Icon(Icons.menu_rounded),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 330),
                child: TextField(
                  controller: controller,
                  onChanged: onSearch,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search your books',
                    hintStyle: const TextStyle(
                      color: AppColors.mutedLight,
                      fontSize: 12,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.mutedLight,
                      size: 18,
                    ),
                    suffixIcon: compact
                        ? null
                        : Padding(
                            padding: const EdgeInsets.only(right: 9),
                            child: Center(
                              widthFactor: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.line),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  '⌘ K',
                                  style: TextStyle(
                                    color: AppColors.mutedLight,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    isDense: true,
                    filled: true,
                    fillColor: const Color(0xFFFBFCFE),
                    contentPadding: const EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onNotifications,
            tooltip: 'Notifications',
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Color(0xFF62718A),
                  size: 20,
                ),
                if (hasUnread)
                  Positioned(
                    top: -1,
                    right: -1,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.4),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: 5),
            Container(width: 1, height: 27, color: AppColors.line),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFFDCE8FF),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Color(0xFF3867C7),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 9),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good morning',
                  style: TextStyle(color: AppColors.muted, fontSize: 10),
                ),
                const SizedBox(height: 2),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.mutedLight,
              size: 15,
            ),
          ],
        ],
      ),
    );
  }
}
