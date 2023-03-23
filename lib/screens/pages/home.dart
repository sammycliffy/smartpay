import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_pay/constants/keys.dart';

import '../../app/locator.dart';
import '../../app_services/local_storage_service.dart';
import '../../models/user_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final localStorage = locator<LocalStorageService>();
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      userModel = UserModel.fromJson(
          json.decode(localStorage.getDataFromDisk(Keys.userData)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      "Hi ${userModel.user?.fullName}",
      style: Theme.of(context).textTheme.displayLarge,
    )));
  }
}
