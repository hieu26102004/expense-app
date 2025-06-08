import 'package:flutter/material.dart';
import '../../domain/models/transaction.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryGridItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case 'salary':
        return Icons.work;
      case 'bonus':
        return Icons.card_giftcard;
      case 'investment':
        return Icons.trending_up;
      case 'freelance':
        return Icons.computer;
      case 'other_income':
        return Icons.more_horiz;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(category.name),
              size: 32,
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[700],
            ),
            const SizedBox(height: 8),
            Text(
              category.name.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 