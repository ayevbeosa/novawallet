import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:novawallet/core/di/service_locator.dart';
import 'package:novawallet/core/settings/locale_cubit.dart';
import 'package:novawallet/core/shell/sync_status_cubit.dart';
import 'package:novawallet/modules/save/presentation/cubits/save_goals_cubit.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/wallet_cubit.dart';

/// Provided above MaterialApp.router so that go_router's top-level routes still have these
/// long-lived cubits as ancestors..
class AppProviders extends StatelessWidget {
  const AppProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocSignalProvider(
      providers: [
        BlocSignalProvider<WalletCubit>(
          create: (_) => WalletCubit(repository: getIt(), connectivity: getIt()),
        ),
        BlocSignalProvider<SaveGoalsCubit>(
          create: (_) => SaveGoalsCubit(repository: getIt()),
        ),
        BlocSignalProvider<SyncStatusCubit>(
          create: (_) => SyncStatusCubit(db: getIt(), connectivity: getIt()),
        ),
        BlocSignalProvider<LocaleCubit>(create: (_) => LocaleCubit()),
      ],
      child: child,
    );
  }
}
