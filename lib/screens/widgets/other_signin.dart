import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/constants/image_assets.dart';

import '../../constants/spaces.dart';

class OtherSignin extends StatelessWidget {
  const OtherSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        heightSpace(34.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: context.widthPercent(0.4),
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGrey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: SvgPicture.asset(AppImages.google)),
            ),
            Container(
              width: context.widthPercent(0.4),
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderGrey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: SvgPicture.asset(AppImages.apple)),
            )
          ],
        )
      ],
    );
  }
}
