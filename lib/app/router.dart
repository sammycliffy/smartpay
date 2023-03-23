import 'package:go_router/go_router.dart';
import 'package:smart_pay/constants/routes.dart';
import 'package:smart_pay/screens/auth_screens/congratulations.dart';
import 'package:smart_pay/screens/auth_screens/login.dart';
import 'package:smart_pay/screens/auth_screens/otp_page.dart';
import 'package:smart_pay/screens/auth_screens/pin_code.dart';
import 'package:smart_pay/screens/auth_screens/pin_validation.dart';
import 'package:smart_pay/screens/auth_screens/reg_form.dart';
import 'package:smart_pay/screens/auth_screens/signup.dart';
import 'package:smart_pay/screens/onboarding/onboarding.dart';
import 'package:smart_pay/screens/onboarding/splashscreen.dart';
import 'package:smart_pay/screens/pages/home.dart';

//list of routers for smartpay
GoRouter router() {
  return GoRouter(routes: <GoRoute>[
    GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (_, GoRouterState state) => SplashScreen()),
    GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder: (_, GoRouterState state) => LoginScreen()),
    GoRoute(
        name: AppRoutes.signUpScreen,
        path: AppRoutes.signUpScreen,
        builder: (_, GoRouterState state) => SignupScreen()),
    GoRoute(
        name: AppRoutes.otpPage,
        path: AppRoutes.otpPage,
        builder: (_, GoRouterState state) => OTPPage(
              email: state.extra as String,
            )),
    GoRoute(
        name: AppRoutes.regForm,
        path: AppRoutes.regForm,
        builder: (_, GoRouterState state) => RegFormScreen(
              email: state.extra as String,
            )),
    GoRoute(
        name: AppRoutes.pinCode,
        path: AppRoutes.pinCode,
        builder: (_, GoRouterState state) => PinCodePage()),
    GoRoute(
        name: AppRoutes.congratulations,
        path: AppRoutes.congratulations,
        builder: (_, GoRouterState state) => Congratulations()),
    GoRoute(
        name: AppRoutes.onboarding,
        path: AppRoutes.onboarding,
        builder: (_, GoRouterState state) => const OnboardingScreen()),
    GoRoute(
        name: AppRoutes.home,
        path: AppRoutes.home,
        builder: (_, GoRouterState state) => const Home()),
    GoRoute(
        name: AppRoutes.pinCodeValidation,
        path: AppRoutes.pinCodeValidation,
        builder: (_, GoRouterState state) => PinCodeValidationPage()),
  ]);
}
