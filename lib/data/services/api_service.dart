import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../app/constants/app_constants.dart';

class ApiService {
  /// NOTE:
  /// - We are NOT uploading images yet (Day 2 scope).
  /// - We send "context + imageCount" like backend schema.
  /// - Optional user key goes as header: X-User-OpenAI-Key
  static Future<Map<String, dynamic>> generateCaption({
    required String platform,
    required String tone,
    required int imageCount,
    required String context,
    String? userApiKey,
    String userTitle = '',
    String userDescription = '',
  }) async {
    final uri = Uri.parse('${AppConstants.baseUrl}/api/generate-caption');

    final headers = <String, String>{'Content-Type': 'application/json'};

    if (userApiKey != null && userApiKey.trim().isNotEmpty) {
      headers['X-User-OpenAI-Key'] = userApiKey.trim();
    }

    final body = jsonEncode({
      'platform': platform,
      'tone': tone,
      'imageCount': imageCount,
      'userTitle': userTitle,
      'userDescription': userDescription,
      'context': context,
    });

    final res = await http.post(uri, headers: headers, body: body);

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('API Error (${res.statusCode}): ${res.body}');
    }

    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
