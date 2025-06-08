class Transaction {
  final int id;
  final int amount;
  final String type;
  final Category? category;
  final String description;
  final String date;
  final String createdAt;
  final String updatedAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    this.category,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    final amountStr = json['amount'].toString();
    final amount = (double.parse(amountStr) * 100).round();
    
    return Transaction(
      id: json['id'] as int,
      amount: amount,
      type: json['type'] as String,
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      description: json['description'] as String,
      date: json['date'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}

class Category {
  final int id;
  final String type;
  final String name;
  final String description;
  final String? userId;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;

  Category({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      deletedAt: json['deletedAt'] as String?,
    );
  }
} 