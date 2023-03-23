import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pay/app/router.dart';
import 'package:smart_pay/app_services/local_storage_service.dart';

GetIt locator = GetIt.instance;

Future setUpLocator() async {
  locator.registerSingleton<GoRouter>(router());
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
