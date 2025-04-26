import 'package:redux/redux.dart';
import 'package:scenario_maker_app/redux/reducers.dart';
import 'package:scenario_maker_app/redux/state.dart';

final store = Store<ScenarioState>(
  scenarioReducer,
  initialState: ScenarioState(),
);