import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SmartPayButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final bool isActive;
  const SmartPayButton({
    super.key,
    this.isActive = false,
    this.onTap,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.3)),
        child: Center(
            child: Text(text!,
                style: const TextStyle(
                    fontFamily: "SFPRODISPLAY",
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16))),
      ),
    );
  }
}
