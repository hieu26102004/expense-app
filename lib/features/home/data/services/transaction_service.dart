import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fe/core/config/app_config.dart';
import '../../domain/models/transaction.dart';
import '../../domain/models/paginated_response.dart';

class TransactionService {

  Future<PaginatedResponse<Transaction>> getTransactions({
    int page = 1,
    int? limit,
    String? type,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy,
    String? sortDirection,
  }) async {
    try {
      final queryParams = {
        'page': page.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (type != null) 'type': type,
        if (category != null) 'category': category,
        if (startDate != null) 'startDate': startDate.toUtc().toIso8601String(),
        if (endDate != null) 'endDate': endDate.toUtc().toIso8601String(),
        if (sortBy != null) 'sortBy': sortBy,
        if (sortDirection != null) 'sortDirection': sortDirection,
      };

      final uri = Uri.parse('${AppConfig.baseUrl}${AppConfig.transactionsEndpoint}')
          .replace(queryParameters: queryParams);

      final headers = await AppConfig.getHeaders();
      final response = await http.get(
        uri,
        headers: headers,
      ).timeout(
        Duration(milliseconds: AppConfig.connectionTimeout),
        onTimeout: () {
          throw 'Connection timeout. Please check your internet connection.';
        },
      );

      if (response.statusCode == 200) {
        return PaginatedResponse.fromJson(
          json.decode(response.body),
          (json) => Transaction.fromJson(json),
        );
      } else if (response.statusCode == 401) {
        throw 'Unauthorized. Please login again.';
      } else {
        final data = jsonDecode(response.body);
        throw data['message'] ?? 'Failed to load transactions (Status: ${response.statusCode})';
      }
    } on FormatException {
      throw 'Invalid response format from server';
    } on http.ClientException {
      throw 'Failed to connect to server. Please check your internet connection.';
    } catch (e) {
      throw 'Failed to load transactions: $e';
    }
  }
} 