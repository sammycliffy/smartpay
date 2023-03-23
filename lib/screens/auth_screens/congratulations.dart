import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/image_assets.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/screens/widgets/custom_button.dart';

class Congratulations extends StatelessWidget {
  Congratulations({super.key});
  final _router = locator<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        heightSpace(50),
        Center(
          child: Image.asset(
            AppImages.thumbsup,
            height: 134,
            width: 140,
          ),
        ),
        heightSpace(32),
        Text(
          "Congratulations, James",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        heightSpace(20),
        Text("You've completed the onboarding, \nyou can start using",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium),
        heightSpace(20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmartPayButton(
            text: "Get Started",
            isActive: true,
            onTap: () => _router.push(AppRoutes.home),
          ),
        )
      ]),
    );
  }
}
