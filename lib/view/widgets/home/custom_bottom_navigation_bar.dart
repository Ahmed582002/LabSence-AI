import 'package:flutter/material.dart';
import 'package:labsense_ai/core/constants/color.dart';

class CustomBottomBar extends StatelessWidget {
  final int? currentIndex;
  final Function(int)? onTap;

  const CustomBottomBar({super.key, this.currentIndex, this.onTap});

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_outlined, label: "Home"),
    _NavItem(icon: Icons.flip, label: "Scan"),
    _NavItem(icon: Icons.history_toggle_off, label: "History"),
    _NavItem(icon: Icons.person_outline, label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (index) {
          final isSelected = index == currentIndex;

          return GestureDetector(
            onTap: () => onTap!(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _items[index].icon,
                  color: isSelected ? AppColors.primary : Colors.grey,
                ),
                const SizedBox(height: 6),
                Text(
                  _items[index].label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? AppColors.primary : Colors.grey,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}
