import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:novawallet/core/router/app_routes.dart';
import 'package:novawallet/core/theme/app_colors.dart';
import 'package:novawallet/modules/save/presentation/components/goal_card.dart';
import 'package:novawallet/modules/save/presentation/cubits/save_goals_cubit.dart';

class GoalListScreen extends StatelessWidget {
  const GoalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SaveGoalsCubit>();
    final state = context.value<SaveGoalsCubit, SaveGoalsState>();

    return RefreshIndicator(
      color: AppColors.cyan,
      backgroundColor: AppColors.surface,
      onRefresh: cubit.refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverAppBar(
            floating: true,
            title: Text('NovaSave'),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => context.push(AppRoutes.createGoal),
                  icon: const Icon(Icons.add_circle_outline_rounded),
                  label: const Text('Create a savings goal'),
                ),
              ),
            ),
          ),
          if (state.goals.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text('No savings goals yet — create one')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList.builder(
                itemCount: state.goals.length,
                itemBuilder: (context, index) {
                  final goal = state.goals[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GoalCard(
                      data: goal,
                      onTap: () => context.push(AppRoutes.goalDetailsWithId(goal.goal.id)),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
