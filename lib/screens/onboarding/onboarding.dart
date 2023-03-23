import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/locator.dart';
import 'package:smart_pay/constants/colors.dart';
import 'package:smart_pay/constants/image_assets.dart';
import 'package:smart_pay/constants/keys.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/constants/spaces.dart';
import 'package:smart_pay/screens/widgets/custom_button.dart';

import '../../app_services/app_state.dart';
import '../../models/slider_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  final _router = locator<GoRouter>();
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 39, horizontal: 27),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    localStorage.saveDataToDisk(Keys.firstInstallKey, true);
                    _router.push(AppRoutes.loginScreen);
                  },
                  child: Text(
                    "Skip",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.textFormBorderGrey, fontSize: 16),
                  )),
            ),
            heightSpace(80),
            Expanded(
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 270,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image:
                                      AssetImage(slides[currentIndex].image))),
                        ),
                        heightSpace(20),
                        Text(
                          slides[currentIndex].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge!,
                        ),
                        heightSpace(16),
                        Text(
                          slides[currentIndex].description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    );
                  }),
            ),
            DotsIndicator(
              dotsCount: slides.length,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.primary,
                size: const Size.square(9.0),
                activeSize: const Size(30.5, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            heightSpace(20),
            SmartPayButton(
              onTap: () {
                localStorage.saveDataToDisk(Keys.firstInstallKey, true);
                _router.push(AppRoutes.loginScreen);
              },
              isActive: true,
              text: "Get Started",
            )
          ],
        ),
      ),
    );
  }
}
