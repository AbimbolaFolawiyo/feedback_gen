import 'package:feedback_gen/api/api_client.dart';
import 'package:feedback_gen/app/app_config.locator.dart';
import '../api/api_response.dart';
import '../constants/constants.dart' show ApiConstants, AuthType;

class AuthRepository {
  final _apiClient = locator<ApiClient>();

  Future<ApiResponse> performAuth({
    required Map<String, dynamic> body,
    required AuthType type,
    String? token,
  }) async {
    return await _apiClient.post(
      type == AuthType.login ? ApiConstants.login : ApiConstants.register,
      body: body,
    );
  }
}
