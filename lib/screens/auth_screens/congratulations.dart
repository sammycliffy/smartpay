import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/app_services/local_storage_service.dart';
import 'package:smart_pay/constants/image_assets.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/screens/widgets/custom_button.dart';

import '../../constants/keys.dart';
import '../../models/user_model.dart';

class Congratulations extends StatefulWidget {
  Congratulations({super.key});

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  final _router = locator<GoRouter>();
  final localStorage = locator<LocalStorageService>();
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      userModel = UserModel.fromJson(
          json.decode(localStorage.getDataFromDisk(Keys.userData)));
    });
  }

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
          "Congratulations, ${userModel.user!.fullName}",
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
