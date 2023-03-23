import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/app_services/local_storage_service.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/constants/image_assets.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/screens/widgets/arrow_back_container.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_pay/screens/widgets/custom_toast.dart';
import '../../constants/keys.dart';
import '../widgets/custom_button.dart';

class PinCodeValidationPage extends StatelessWidget {
  PinCodeValidationPage({super.key});

  final _router = locator<GoRouter>();
  final storage = locator<LocalStorageService>();
  final _pinController = TextEditingController();
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const ArrowBackContainer(),
            SizedBox(
              height: context.heightPercent(.04),
            ),
            Text(
              "Enter your PIN to continue",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(
              height: context.heightPercent(.02),
            ),
            Text(
                "We use state-of-the-art security measures to protect your information at all times",
                style: Theme.of(context).textTheme.displayMedium),
            SizedBox(
              height: context.heightPercent(.032),
            ),
            Pinput(
              onCompleted: (_) {
                isValidated = true;
              },
              controller: _pinController,
              cursor: Container(
                width: 2,
                height: 20,
                color: AppColors.textFormBorderGrey,
              ),
              obscureText: true,
              length: 5,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w700),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: AppColors.textFormBorderGrey, width: 2)),
                ),
              ),
            ),
            heightSpace(100),
            SmartPayButton(
              onTap: () {
                String oldPin = storage.getDataFromDisk(Keys.pinCode);
                if (oldPin == _pinController.text) {
                  _router.push((AppRoutes.home));
                } else {
                  ToastUtils.showToast("Pin is incorrect");
                }
              },
              isActive: isValidated,
              text: "Create PIN",
            ),
            heightSpace(42.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SvgPicture.asset(AppImages.line)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text("OR",
                      style: TextStyle(
                          fontFamily: "SFPRODISPLAY",
                          color: AppColors.textGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                ),
                Expanded(child: SvgPicture.asset(AppImages.line)),
              ],
            ),
            heightSpace(20),
            Center(
              child: TextButton(
                  onPressed: () => _router.push(AppRoutes.loginScreen),
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 16),
                  )),
            )
          ]),
        ),
      )),
    );
  }
}
