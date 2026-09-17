import 'package:go_router/go_router.dart';
import 'package:novawallet/core/router/app_routes.dart';
import 'package:novawallet/core/settings/settings_screen.dart';
import 'package:novawallet/core/shell/app_shell.dart';
import 'package:novawallet/modules/save/presentation/screens/create_goal_screen.dart';
import 'package:novawallet/modules/save/presentation/screens/goal_detail_screen.dart';
import 'package:novawallet/modules/save/presentation/screens/goal_list_screen.dart';
import 'package:novawallet/modules/wallet/presentation/screens/send_money_flow_screen.dart';
import 'package:novawallet/modules/wallet/presentation/screens/transaction_history_screen.dart';
import 'package:novawallet/modules/wallet/presentation/screens/wallet_home_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.wallet,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.wallet,
              builder: (context, state) => const WalletHomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.save,
              builder: (context, state) => const GoalListScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: AppRoutes.settings, builder: (context, state) => const SettingsScreen()),
    GoRoute(path: AppRoutes.send, builder: (context, state) => const SendMoneyFlowScreen()),
    GoRoute(
      path: AppRoutes.transactions,
      builder: (context, state) => const TransactionHistoryScreen(),
    ),
    GoRoute(path: AppRoutes.createGoal, builder: (context, state) => const CreateGoalScreen()),
    GoRoute(
      path: AppRoutes.goalDetails,
      builder: (context, state) => GoalDetailScreen(goalId: state.pathParameters['goalId']!),
    ),
  ],
);
