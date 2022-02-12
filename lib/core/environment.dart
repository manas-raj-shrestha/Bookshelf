import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final baseUrl = dotenv.env['BASE_URL'] ?? '';
  static final apiKey = dotenv.env['API_KEY'] ?? '';
  static final apiHost = dotenv.env['API_HOST'] ?? '';
}
