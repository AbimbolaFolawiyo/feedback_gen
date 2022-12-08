import 'api_response.dart';

abstract class ApiClient {
  Future<ApiResponse> fetch(String path, {String? token});
  Future<ApiResponse> post(String path,
      {required Map<String, dynamic> body, String? token});
}
