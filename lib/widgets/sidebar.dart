import 'package:flutter/material.dart';
import 'package:balamurugan_erp/core/theme/colors.dart';
import 'package:balamurugan_erp/models/mock_data.dart';

class Sidebar extends StatelessWidget {
  final String companyName;
  final bool collapsed;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onCollapse;
  final VoidCallback? onLogout;
  final bool isAdmin;

  const Sidebar({
    super.key,
    required this.collapsed,
    required this.selectedIndex,
    required this.companyName,
    required this.onSelect,
    required this.onCollapse,
    this.onLogout,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.navy,
      child: SizedBox(
        width: collapsed ? 74 : 254,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: collapsed
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        image: const DecorationImage(
                          image: AssetImage('assets/logo.png'),
                          fit: BoxFit.contain,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 15,
                            offset: Offset(0, 7),
                          ),
                        ],
                      ),
                    ),
                    if (!collapsed) ...[
                      const SizedBox(width: 11),
                      const Text(
                        'BALAMURUGAN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Text(
                        '.',
                        style: TextStyle(
                          color: Color(0xFF74D2BA),
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ],
                ),
                if (!collapsed) ...[
                  const SizedBox(height: 26),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .07),
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: Colors.white.withValues(alpha: .11)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'WORKSPACE',
                                style: TextStyle(
                                  color: Color(0xFF8D9DBB),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                companyName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF8D9DBB),
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _navSection('WORKSPACE', [0, 1]),
                      _navSection('SALES', [2, 3, 4, 5]),
                      _navSection('PURCHASES', [6, 7, 8]),
                      _navSection('MANAGE', [9, 10, 11, 12]),
                      if (isAdmin) _navSection('SETTINGS', [13]),
                    ],
                  ),
                ),
                if (!collapsed) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .06),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            color: const Color(0xFF63C5AE).withValues(alpha: .13),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.help_outline_rounded,
                            color: Color(0xFF6DD0B7),
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'NEED A HAND?\n',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                              children: [
                                TextSpan(
                                  text: 'VISIT THE HELP CENTER',
                                  style: TextStyle(
                                    color: Color(0xFFB9C6DC),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.north_east_rounded,
                          color: Color(0xFF8FA1C0),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                if (onLogout != null) ...[
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout_rounded, color: AppColors.red, size: 17),
                      label: collapsed ? const SizedBox.shrink() : const Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.w900)),
                      style: TextButton.styleFrom(
                        alignment: collapsed ? Alignment.center : Alignment.centerLeft,
                        foregroundColor: AppColors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: collapsed ? 0 : 12,
                          vertical: 9,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: onCollapse,
                    icon: Icon(
                      collapsed
                          ? Icons.keyboard_double_arrow_right_rounded
                          : Icons.keyboard_double_arrow_left_rounded,
                      color: const Color(0xFF8FA1C0),
                      size: 17,
                    ),
                    label: collapsed
                        ? const SizedBox.shrink()
                        : const Text('COLLAPSE SIDEBAR', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                    style: TextButton.styleFrom(
                      alignment: collapsed
                          ? Alignment.center
                          : Alignment.centerLeft,
                      foregroundColor: const Color(0xFF8FA1C0),
                      padding: EdgeInsets.symmetric(
                        horizontal: collapsed ? 0 : 12,
                        vertical: 9,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navSection(String title, List<int> indexes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!collapsed)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF7083A5),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ...indexes.map(_navButton),
        ],
      ),
    );
  }

  Widget _navButton(int index) {
    if (index >= navEntries.length) return const SizedBox.shrink();
    final entry = navEntries[index];
    final active = index == selectedIndex;
    final button = TextButton(
      onPressed: () => onSelect(index),
      style: TextButton.styleFrom(
        alignment: collapsed ? Alignment.center : Alignment.centerLeft,
        backgroundColor: active ? AppColors.navyLight : Colors.transparent,
        foregroundColor: active ? Colors.white : const Color(0xFFACB9D0),
        padding: EdgeInsets.symmetric(
          horizontal: collapsed ? 0 : 12,
          vertical: 10,
        ),
        minimumSize: const Size.fromHeight(39),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: active
              ? const BorderSide(color: Color(0xFF67C7B0), width: 3)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: collapsed ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Icon(entry.icon, size: 17),
          if (!collapsed) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                entry.label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            if (entry.badge != null)
              Container(
                constraints: const BoxConstraints(minWidth: 21),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                height: 19,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF355489)
                      : Colors.white.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.badge!,
                  style: const TextStyle(
                    color: Color(0xFFD9E1EF),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
          ],
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: collapsed
          ? Tooltip(message: entry.label, child: button)
          : button,
    );
  }
}
