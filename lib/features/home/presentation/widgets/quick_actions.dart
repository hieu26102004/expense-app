import 'package:flutter/material.dart';
import '../screens/add_income_screen.dart';
import '../screens/add_expense_screen.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddIncomeScreen()),
            ).then((success) {
              if (success == true) {
                // Refresh data if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Income added successfully')),
                );
              }
            });
          },
        ),
        _buildQuickActionButton(
          context,
          'Add Expense',
          Icons.remove_circle_outline,
          Colors.red,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
            ).then((success) {
              if (success == true) {
                // Refresh data if needed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense added successfully')),
                );
              }
            });
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