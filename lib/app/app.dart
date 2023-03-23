import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/colors.dart';

class SmartPay extends StatelessWidget {
  SmartPay({Key? key}) : super(key: key);
  final _router = locator<GoRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Smart Pay",
      theme: ThemeData(
          fontFamily: "SFPRODISPLAY",
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontFamily: "SFPRODISPLAY",
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 24),
            displayMedium: TextStyle(
                fontFamily: "SFPRODISPLAY",
                color: AppColors.textGrey,
                fontWeight: FontWeight.w400,
                fontSize: 16),
          )),
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
