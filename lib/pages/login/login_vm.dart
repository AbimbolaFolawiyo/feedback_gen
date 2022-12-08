import '../../api/api_exceptions.dart';
import '../../constants/constants.dart' show SnackbarType;
import 'package:stacked_services/stacked_services.dart';

import '../../app/app_config.locator.dart';
import '../../services/services.dart' show AuthService;

import '../../util/utils.dart' show ValidatorMixin;
import 'package:stacked/stacked.dart';
import 'login_view.form.dart';

class LoginViewModel extends FormViewModel with ValidatorMixin {
  final _auth = locator<AuthService>();
  final _navigator = locator<NavigationService>();
  final _snackbar = locator<SnackbarService>();

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  void login() async {
    final data = {
      EmailValueKey: emailValue,
      PasswordValueKey: passwordValue,
    };
    if (isFormValid &&
        data.values
            .any((element) => element != null ? element.isNotEmpty : false)) {
      setBusy(true);
      final response = await _auth.login(data: data);
      response.map(
        success: (value) {
          setBusy(false);
        },
        failure: (value) {
          setBusy(false);
          _snackbar.showCustomSnackBar(
            message: ApiExceptions.getErrorMessage(value.error),
            variant: SnackbarType.failure,
          );
        },
      );
    }
  }

  void to(String route) {
    _navigator.pushNamedAndRemoveUntil(route);
  }

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  @override
  void setFormStatus() {
    if (hasEmail) {
      setEmailValidationMessage(validateEmail(emailValue!));
    }
    if (hasPassword) {
      setPasswordValidationMessage(validateNull(passwordValue!));
    }
  }
}
