import 'package:flutter/material.dart';

import 'package:novawallet/nova_wallet_app.dart';
import 'package:novawallet/core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const NovaWalletApp());
}
