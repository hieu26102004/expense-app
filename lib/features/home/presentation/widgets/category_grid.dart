import 'package:flutter/material.dart';
import '../../domain/models/transaction.dart';
import 'category_grid_item.dart';

class CategoryGrid extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final Function(Category) onCategorySelected;

  const CategoryGrid({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryGridItem(
              category: category,
              isSelected: selectedCategory?.id == category.id,
              onTap: () => onCategorySelected(category),
            );
          },
        ),
      ],
    );
  }
} 