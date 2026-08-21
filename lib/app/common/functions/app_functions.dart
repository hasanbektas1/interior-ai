import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/config/config.dart';
import 'package:interior_ai/app/common/get_it/get_it.dart';
import 'package:interior_ai/core/helpers/device/device_info_helper.dart';
import 'package:interior_ai/core/helpers/purchase_service.dart';
import 'package:interior_ai/core/storage/collection_storage.dart';
import 'package:interior_ai/core/storage/tutorial_storage.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // FlutterNativeSplash.preserve(
    //     widgetsBinding: ensureInitialized); //Splash'te silmelisin
    await DeviceInfoHelper.instance.init();
    await CollectionStorage.init();
    await TutorialStorage.init();
    await PurchaseService.configure();
    Config.currentEnvironment = Environment.development;
    ServiceLocator().setup();
  }
}
