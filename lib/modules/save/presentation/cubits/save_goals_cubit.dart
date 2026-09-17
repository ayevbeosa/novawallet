import 'dart:async';

import 'package:bloc_signals/bloc_signals.dart';
import 'package:novawallet/modules/save/data/models/goal_view_data.dart';
import 'package:novawallet/modules/save/data/repositories/save_repository.dart';

class SaveGoalsCubit extends CubitSignal<SaveGoalsState> {
  SaveGoalsCubit({required SaveRepository repository})
    : _repository = repository,
      super(initialState: SaveGoalsState.initial) {
    _sub = repository.watch().listen((goals) {
      emit(SaveGoalsState(status: SaveGoalsLoadStatus.ready, goals: goals));
    });
  }

  final SaveRepository _repository;
  late final StreamSubscription<List<GoalViewData>> _sub;

  Future<void> refresh() => _repository.refresh();

  Future<void> retryFailed(String idempotencyKey) => _repository.retryFailed(idempotencyKey);

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}

enum SaveGoalsLoadStatus { loading, ready }

class SaveGoalsState {
  const SaveGoalsState({required this.status, this.goals = const []});

  final SaveGoalsLoadStatus status;
  final List<GoalViewData> goals;

  static const initial = SaveGoalsState(status: SaveGoalsLoadStatus.loading);
}
