import 'package:flutter/material.dart';
import '../../data/services/transaction_service.dart';
import '../../domain/models/transaction.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  final TransactionService _transactionService = TransactionService();
  List<Transaction> _transactions = [];
  bool _isLoading = true;
  String? _error;
  int _currentPage = 1;
  bool _hasMorePages = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadTransactions();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      _loadMore();
    }
  }

  Future<void> _loadTransactions() async {
    if (!_hasMorePages) return;

    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final response = await _transactionService.getTransactions(page: _currentPage);
      
      setState(() {
        _transactions.addAll(response.data);
        _hasMorePages = _currentPage < response.meta.totalPages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (!_isLoading && _hasMorePages) {
      _currentPage++;
      await _loadTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Transactions'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _loadTransactions,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_transactions.isEmpty && _isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _transactions = [];
          _currentPage = 1;
          _hasMorePages = true;
        });
        await _loadTransactions();
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: _transactions.length + (_hasMorePages ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _transactions.length) {
            return _hasMorePages
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }

          final transaction = _transactions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: transaction.type == 'income' ? Colors.green : Colors.red,
                child: Icon(
                  transaction.type == 'income' ? Icons.add : Icons.remove,
                  color: Colors.white,
                ),
              ),
              title: Text(transaction.description),
              subtitle: Text(transaction.category?.name ?? 'No Category'),
              trailing: Text(
                '\$${(transaction.amount / 100).toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.type == 'income' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 