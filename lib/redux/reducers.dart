import 'package:scenario_maker_app/redux/actions.dart';
import 'package:scenario_maker_app/redux/state.dart';

ScenarioState scenarioReducer(ScenarioState state, dynamic action) {
  if (action is LoadScenarioAction) {
    return state.copyWith(loadingStatus: LoadingStatus.generating);
  } else if (action is LoadScenarioSuccessAction) {
    return state.copyWith(loadingStatus: LoadingStatus.success);
  } else if (action is LoadScenarioFailureAction) {
    return state.copyWith(loadingStatus: LoadingStatus.failure);
  }
  return state;
}