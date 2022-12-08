import 'package:dio/dio.dart';
import 'package:feedback_gen/api/api_exceptions.dart';
import 'package:feedback_gen/api/api_result.dart';
import 'package:feedback_gen/app/app_config.logger.dart';

import '../app/app_config.locator.dart';
import '../constants/constants.dart' show AuthType;
import '../repositories/repositories.dart' show AuthRepository;

class AuthService {
  final _authRepo = locator<AuthRepository>();
  final logger = getLogger('AuthService');

  Future<ApiResult> login({required Map<String, dynamic> data}) async {
    try {
      logger.i('Attempting signing in $data');
      final response =
          await _authRepo.performAuth(body: data, type: AuthType.login);
      return ApiResult.success(data: response.data);
    } on DioError catch (e) {
      logger.e(e.message);
      return ApiResult.failure(error: ApiExceptions.getDioException(e.error));
    } catch (_) {
      rethrow;
    }
  }

  Future<ApiResult> register({required Map<String, dynamic> data}) async {
    try {
      logger.i('Attempting signing up $data');
      final response =
          await _authRepo.performAuth(body: data, type: AuthType.register);
      return ApiResult.success(data: response.data);
    } on DioError catch (e) {
      logger.e(e.message);
      return ApiResult.failure(error: ApiExceptions.getDioException(e.error));
    } catch (_) {
      rethrow;
    }
  }
}
