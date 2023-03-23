import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:smart_pay/api/auth_services.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/colors.dart';

import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/screens/widgets/arrow_back_container.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_pay/screens/widgets/loader.dart';
import 'package:smart_pay/screens/widgets/timer.dart';
import '../widgets/custom_button.dart';

class OTPPage extends StatefulWidget {
  final String email;
  const OTPPage({super.key, required this.email});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _router = locator<GoRouter>();
  bool isLoading = false;
  final _pinController = TextEditingController();
  bool isValidated = false;

  final AuthService _authService = AuthService();

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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ArrowBackContainer(),
                      SizedBox(
                        height: context.heightPercent(.04),
                      ),
                      Text(
                        "Verify it's you ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SizedBox(
                        height: context.heightPercent(.02),
                      ),
                      Row(
                        children: [
                          Text("We send a code to (",
                              style: Theme.of(context).textTheme.displayMedium),
                          Text("*****@mail.com",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: AppColors.primary)),
                          Text("). Enter it ",
                              style: Theme.of(context).textTheme.displayMedium),
                        ],
                      ),
                      Text("here to verify your identity",
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(
                        height: context.heightPercent(.032),
                      ),
                      Pinput(
                        length: 5,
                        showCursor: false,
                        controller: _pinController,
                        keyboardType: TextInputType.number,
                        onCompleted: (value) {
                          isValidated = true;
                        },
                        focusedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.textFormBorderGrey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                          decoration: BoxDecoration(
                            color: AppColors.formGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      heightSpace(32),
                      Center(
                        child: Text(
                          "Resend Code in 30 secs",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textGrey1),
                        ),
                      ),
                      heightSpace(67),
                      SmartPayButton(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool result = await _authService.passwordOTP(
                              widget.email, _pinController.text);
                          if (result) {
                            _router.push(AppRoutes.regForm,
                                extra: widget.email);
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        isActive: isValidated,
                        text: "Confirm",
                      ),
                      heightSpace(42.5),
                    ]),
              ),
            )),
    );
  }
}
