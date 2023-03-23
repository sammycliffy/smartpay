import 'package:flutter/material.dart';
import 'package:smart_pay/app/app.dart';
import 'package:smart_pay/app/locator.dart';

void main() {
  //Setting up service locator
  setUpLocator();
  runApp(SmartPay());
}
