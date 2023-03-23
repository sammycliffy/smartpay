import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/api/auth_services.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/screens/widgets/arrow_back_container.dart';
import 'package:smart_pay/screens/widgets/loader.dart';
import '../../helpers/form_helper.dart';
import '../widgets/custom_button.dart';
import '../widgets/other_signin.dart';
import '../widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _router = locator<GoRouter>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isValidated = false;
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

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
                        Text(
                          "Hi There! 👋",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(
                          height: context.heightPercent(.02),
                        ),
                        Text("Welcome back, Sign in to your account",
                            style: Theme.of(context).textTheme.displayMedium),
                        SizedBox(
                          height: context.heightPercent(.032),
                        ),
                        SmartPayTextFormField(
                          textEditingController: emailController,
                          keyBoardType: TextInputType.emailAddress,
                          validator: emailValidation,
                          hintText: "Email",
                        ),
                        heightSpace(16),
                        SmartPayTextFormField(
                          textEditingController: passwordController,
                          keyBoardType: TextInputType.text,
                          validator: passwordValidation,
                          hintText: "Password",
                          isPassword: true,
                        ),
                        heightSpace(24),
                        Text(
                          "Forgot Password?",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 16, color: AppColors.green),
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
                              bool result = await authService.login(
                                  emailController.text,
                                  passwordController.text);
                              if (result) {
                                _router.push(AppRoutes.home);
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                        heightSpace(40),
                        const OtherSignin(),
                        heightSpace(60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            TextButton(
                              onPressed: () =>
                                  _router.push(AppRoutes.signUpScreen),
                              child: Text(
                                "Sign Up",
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
