import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/l10n/generated/app_localizations.dart';
import 'package:novawallet/core/router/app_routes.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/modules/wallet/presentation/cubits/send_money_cubit.dart';

class SendResultView extends StatelessWidget {
  const SendResultView({required this.state, super.key});

  final SendMoneyState state;

  @override
  Widget build(BuildContext context) {
    final offline = state.outcome!.kind == SendMoneyOutcomeKind.queuedOffline;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                offline ? Icons.cloud_off_rounded : Icons.check_circle_rounded,
                color: offline ? AppColors.gold : AppColors.green,
                size: 64,
              ),
              const SizedBox(height: 20),
              Text(
                offline ? l10n.pendingOffline : l10n.sendSuccess,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(
                offline
                    ? "Your transfer to ${state.recipient} is queued locally and hasn't left the device yet."
                    : 'Your transfer to ${state.recipient} has been queued and will confirm in a moment.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.wallet),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
