import 'package:flutter/material.dart';
import '../../data/services/transaction_service.dart';
import '../../domain/models/transaction.dart';
import '../widgets/amount_input_field.dart';
import '../widgets/category_grid.dart';
import '../widgets/description_input_field.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  Category? _selectedCategory;
  bool _isLoading = false;
  List<Category> _categories = [];
  bool _isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await TransactionService().getCategories();
      if (mounted) {
        setState(() {
          _categories = categories.where((c) => c.type == 'income').toList();
          _selectedCategory = _categories.isNotEmpty ? _categories.first : null;
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading categories: $e')),
        );
        setState(() {
          _isLoadingCategories = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final amount = double.parse(_amountController.text);
      final description = _descriptionController.text;

      await TransactionService().createTransaction(
        amount: amount,
        type: 'income',
        category: _selectedCategory!.name,
        description: description,
        date: DateTime.now(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Income added successfully')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Income'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            AmountInputField(controller: _amountController),
            const SizedBox(height: 16),
            if (_isLoadingCategories)
              const Center(child: CircularProgressIndicator())
            else if (_categories.isEmpty)
              const Center(child: Text('No categories available'))
            else
              CategoryGrid(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            const SizedBox(height: 16),
            DescriptionInputField(controller: _descriptionController),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Add Income'),
            ),
          ],
        ),
      ),
    );
  }
} 