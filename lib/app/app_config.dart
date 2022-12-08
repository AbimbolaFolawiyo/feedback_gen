import 'package:feedback_gen/api/api_client.dart';
import 'package:feedback_gen/api/dio_client.dart';
import 'package:feedback_gen/pages/login/login_view.dart';
import 'package:feedback_gen/pages/register/register_view.dart';
import 'package:feedback_gen/services/auth_service.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../repositories/repositories.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: RegisterView)
  ],
  dependencies: [
    LazySingleton(classType: DioClient, asType: ApiClient),
    LazySingleton(classType: AuthRepository),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: NavigationService)
  ],
  logger: StackedLogger(),
)
class AppConfig {}
