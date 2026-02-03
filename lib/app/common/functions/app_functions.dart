import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interior_ai/app/common/config/config.dart';
import 'package:interior_ai/app/common/get_it/get_it.dart';
import 'package:interior_ai/core/helpers/device/device_info_helper.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(
    //     widgetsBinding: ensureInitialized); //Splash'te silmelisin
    await DeviceInfoHelper.instance.init();
    Config.currentEnvironment = Environment.development;
    ServiceLocator().setup();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
