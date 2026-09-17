import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/shell/sync_status_cubit.dart';
import 'package:novawallet/core/widgets/offline_banner.dart';

/// The bottom-tab shell: Wallet and NovaSave, with a persistent offline
/// banner overlaid across both — fed by [SyncStatusCubit].
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final syncStatus = context.value<SyncStatusCubit, SyncStatusState>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            OfflineBanner(
              visible: !syncStatus.isOnline,
              pendingCount: syncStatus.pendingCount,
            ),
            Expanded(
              child: navigationShell,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goBranch,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings_rounded),
            label: 'NovaSave',
          ),
        ],
      ),
    );
  }
}
