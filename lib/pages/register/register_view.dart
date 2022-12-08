import 'package:feedback_gen/app/app_config.router.dart';
import 'package:feedback_gen/pages/register/register_vm.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../../constants/constants.dart';
import '../../shared/shared.dart';
import '../../util/utils.dart';
import 'register_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'fullName'),
    FormTextField(name: 'email'),
    FormTextField(name: 'phone'),
    FormTextField(name: 'password')
  ],
)
class RegisterView extends StatelessWidget with $RegisterView {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(75.h),
                          CustomText(text: Helper.greeting()),
                          Gap(31.h),
                          const CustomText(text: Strings.fullName),
                          Gap(4.h),
                          CustomTextField(
                            controller: fullNameController,
                            focusNode: fullNameFocusNode,
                            hint: '${Strings.enter} ${Strings.fullName}',
                          ),
                          if (model.hasFullNameValidationMessage)
                            ErrorText(
                              errorText: model.fullNameValidationMessage!,
                            ),
                          Gap(17.h),
                          const CustomText(text: Strings.emailAddress),
                          Gap(4.h),
                          CustomTextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            hint: '${Strings.enter} ${Strings.emailAddress}',
                          ),
                          if (model.hasEmailValidationMessage)
                            ErrorText(errorText: model.emailValidationMessage!),
                          Gap(17.h),
                          const CustomText(text: Strings.phoneNumber),
                          Gap(4.h),
                          CustomTextField(
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            hint: '${Strings.enter} ${Strings.phoneNumber}',
                            keyboard: const TextInputType.numberWithOptions(
                              signed: true,
                            ),
                          ),
                          if (model.hasPhoneValidationMessage)
                            ErrorText(errorText: model.phoneValidationMessage!),
                          Gap(17.h),
                          const CustomText(text: Strings.password),
                          Gap(4.h),
                          CustomTextField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            action: TextInputAction.done,
                            hint: '${Strings.enter} ${Strings.password}',
                          ),
                          if (model.hasPasswordValidationMessage)
                            ErrorText(
                              errorText: model.passwordValidationMessage!,
                            ),
                          Gap(12.h),
                          Expanded(
                            child: _TermsAndAgreement(
                              termsAccepted: model.termsAccepted,
                              toggleTandA: (value) =>
                                  model.toggleAcceptTerms(value!),
                            ),
                          ),
                          Gap(40.h),
                          ValueListenableBuilder<TextEditingValue>(
                            valueListenable: fullNameController,
                            builder: (context, fullName, child) =>
                                ValueListenableBuilder<TextEditingValue>(
                              valueListenable: emailController,
                              builder: (context, email, child) {
                                return ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: phoneController,
                                  builder: (context, phone, child) =>
                                      ValueListenableBuilder<TextEditingValue>(
                                    valueListenable: passwordController,
                                    builder: (context, password, child) =>
                                        CustomButton(
                                      onTap: model.register,
                                      absorbing: fullName.text.isEmpty ||
                                          email.text.isEmpty ||
                                          phone.text.isEmpty ||
                                          password.text.isEmpty ||
                                          model.isBusy,
                                      text: Strings.signUp,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Gap(16.h),
                          GestureDetector(
                            onTap: () => model.to(Routes.loginView),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(text: Strings.haveAccount),
                                Gap(5.w),
                                const CustomText(
                                  text: Strings.login,
                                  color: AppColors.kBrown,
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TermsAndAgreement extends StatelessWidget {
  const _TermsAndAgreement({
    Key? key,
    this.toggleTandA,
    required this.termsAccepted,
  }) : super(key: key);
  final Function(bool?)? toggleTandA;
  final bool termsAccepted;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          splashRadius: 0,
          checkColor: Colors.white,
          activeColor: AppColors.kBrown,
          value: termsAccepted,
          onChanged: toggleTandA,
          side: const BorderSide(
            color: AppColors.kPrimary,
            width: .5,
          ),
        ),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: Strings.acceptTandC,
                  style: TextStyle(
                    color: AppColors.kPrimary,
                    fontSize: 12.sp,
                  ),
                ),
                TextSpan(
                  text: ' ${Strings.useAgreement}',
                  style: TextStyle(
                    color: AppColors.kBrown,
                    fontSize: 12.sp,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                  text: ' ${Strings.and} ',
                  style: TextStyle(
                    color: AppColors.kPrimary,
                    fontSize: 12.sp,
                  ),
                ),
                TextSpan(
                  text: Strings.privacyPolicy,
                  style: TextStyle(
                    color: AppColors.kBrown,
                    fontSize: 12.sp,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
