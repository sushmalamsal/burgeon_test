import 'package:burgeon/services/get_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.baseUrl =
        'https://dev-demo.all-attend.com/dev-api/user/public/';
  }

  // Login function
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'dev-api/auth/admin-login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  // Fetch data function
  Future<GetModel> fetchData() async {
    const String url =
        "https://dev-demo.all-attend.com/dev-api/user/public/hr49gatde0lhpznok4vuvv";
    try {
      final response = await _dio.get(url);
      return GetModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Failed to fetch data: $e");
    }
  }
}
