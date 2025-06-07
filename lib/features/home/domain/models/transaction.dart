class Transaction {
  final int id;
  final String amount;
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
    return Transaction(
      id: json['id'],
      amount: json['amount'],
      type: json['type'],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      description: json['description'],
      date: json['date'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
      id: json['id'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
    );
  }
} 