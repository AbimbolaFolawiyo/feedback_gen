import 'package:feedback_gen/util/validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../api/api_exceptions.dart';
import '../../app/app_config.locator.dart';
import '../../constants/constants.dart';
import '../../services/services.dart';
import 'register_view.form.dart';

class RegisterViewModel extends FormViewModel with ValidatorMixin {
  final _auth = locator<AuthService>();
  final _navigator = locator<NavigationService>();
  final _snackbar = locator<SnackbarService>();

  bool _termsAccepted = false;
  bool get termsAccepted => _termsAccepted;

  void register() async {
    final data = {
      FullNameValueKey: fullNameValue,
      EmailValueKey: emailValue,
      PhoneValueKey: phoneValue,
      PasswordValueKey: passwordValue,
    };
    if (isFormValid &&
        data.values
            .any((element) => element != null ? element.isNotEmpty : false)) {
      setBusy(true);
      final response = await _auth.register(data: data);
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

  void toggleAcceptTerms(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  void to(String route) {
    _navigator.pushNamedAndRemoveUntil(route);
  }

  @override
  void setFormStatus() {
    if (hasFullName) {
      setFullNameValidationMessage(validateNull(fullNameValue!));
    }
    if (hasEmail) {
      setEmailValidationMessage(validateEmail(emailValue!));
    }

    if (hasPhone) {
      setPhoneValidationMessage(validatePhone(phoneValue!));
    }

    if (hasPassword) {
      setPasswordValidationMessage(validatePassword(passwordValue!));
    }
  }
}
