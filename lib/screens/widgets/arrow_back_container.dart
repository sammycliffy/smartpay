import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/colors.dart';

class ArrowBackContainer extends StatelessWidget {
  const ArrowBackContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final router = locator<GoRouter>();
    return GestureDetector(
      onTap: () => router.pop(context),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, top: 8, left: 5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.borderGrey,
            )),
        child: const Center(
            child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.primary,
          size: 18,
        )),
      ),
    );
  }
}
