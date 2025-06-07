import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildQuickActionButton(
          context,
          'Add Income',
          Icons.add_circle_outline,
          Colors.green,
          () {
            // TODO: Implement add income
          },
        ),
        _buildQuickActionButton(
          context,
          'Add Expense',
          Icons.remove_circle_outline,
          Colors.red,
          () {
            // TODO: Implement add expense
          },
        ),
        _buildQuickActionButton(
          context,
          'Transfer',
          Icons.swap_horiz,
          Colors.blue,
          () {
            // TODO: Implement transfer
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
} 