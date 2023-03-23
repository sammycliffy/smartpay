import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/api/auth_services.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/screens/widgets/arrow_back_container.dart';
import 'package:smart_pay/screens/widgets/loader.dart';
import 'package:smart_pay/screens/widgets/other_signin.dart';
import 'package:smart_pay/screens/widgets/text_form_field.dart';

import '../../constants/colors.dart';
import '../../constants/routes.dart';
import '../../constants/spaces.dart';
import '../../helpers/form_helper.dart';
import '../widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  bool isLoading = false;
  final _router = locator<GoRouter>();
  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Form(
                  key: _formKey,
                  onChanged: () => setState(
                      () => isValidated = _formKey.currentState!.validate()),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ArrowBackContainer(),
                        SizedBox(
                          height: context.heightPercent(.04),
                        ),
                        Row(
                          children: [
                            Text(
                              "Create a",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            widthSpace(6),
                            Text(
                              "Smartpay",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: AppColors.green),
                            ),
                          ],
                        ),
                        Text(
                          "account",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: context.heightPercent(.032),
                        ),
                        SmartPayTextFormField(
                          textEditingController: emailController,
                          keyBoardType: TextInputType.emailAddress,
                          hintText: "Email",
                          validator: emailValidation,
                        ),
                        heightSpace(24),
                        SmartPayButton(
                          isActive: isValidated,
                          text: "Sign In",
                          onTap: () async {
                            if (isValidated) {
                              setState(() {
                                isLoading = true;
                              });

                              bool result = await _authService
                                  .getEmailToken(emailController.text);
                              log(result.toString());
                              if (result) {
                                _router.push(AppRoutes.otpPage,
                                    extra: emailController.text);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                        heightSpace(42.5),
                        const OtherSignin(),
                        heightSpace(70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            TextButton(
                              onPressed: () =>
                                  _router.push(AppRoutes.loginScreen),
                              child: Text(
                                "Sign In",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.green),
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              ),
            )),
    );
  }
}
