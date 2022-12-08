import 'package:dio/dio.dart';
import '../app/app_config.logger.dart';

class DioInterceptor extends Interceptor {
  final log = getLogger('DioInterceptor');
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log.i('STATUSCODE: ${err.response!.statusCode}');
    log.i('EXCEPTION: ${err.response!.data}');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.i('METHOD/ENDPOINT:{options.method} ${options.uri.toString()}');
    log.i('HEADER: ${options.headers.toString()}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.i('STATUSCODE: ${response.statusCode.toString()}');
    log.i('DATA: ${response.data}');
    handler.next(response);
  }
}
