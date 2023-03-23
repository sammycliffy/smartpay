import 'package:go_router/go_router.dart';
import 'package:smart_pay/app_services/local_storage_service.dart';

import '../app/locator.dart';
import '../constants/keys.dart';
import '../constants/routes.dart';

final localStorage = locator<LocalStorageService>();
final router = locator<GoRouter>();
getAppState() {
  bool firstInstall =
      localStorage.getDataFromDisk(Keys.firstInstallKey) ?? false;

  String isLoggedIn = localStorage.getDataFromDisk(Keys.userKey) ?? "";

  if (!firstInstall) {
    router.push(AppRoutes.onboarding);
    return;
  }
  if (isLoggedIn.isEmpty) {
    router.push(AppRoutes.loginScreen);
    return;
  }

  router.push(AppRoutes.pinCodeValidation);
}
