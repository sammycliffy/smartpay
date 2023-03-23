import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app_services/app_state.dart';
import 'package:smart_pay/constants/routes.dart';

import '../../app/locator.dart';
import '../../constants/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animationOffset;
  final _router = locator<GoRouter>();

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // Create the animation
    _animationOffset =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
            .animate(_animationController);

    // Start the animation
    _animationController.forward();

    Timer(const Duration(seconds: 4), () {
      // getAppState();
      _router.push(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _animationOffset,
        child: Center(child: SvgPicture.asset(AppImages.logo)),
      ),
    );
  }
}
